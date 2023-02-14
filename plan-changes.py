import os
import subprocess
import json
import urllib.request
import urllib.error


def slack_alert(add, destroy, change, replacements):
    attachments = []

    if add:
        attachments.append({
            'color': 'good',
            'title': 'Add',
            'text': '\n'.join(add)
        })

    if destroy:
        attachments.append({
            'color': 'danger',
            'title': 'Destroy',
            'text': '\n'.join(destroy)
        })

    if change:
        attachments.append({
            'color': 'warning',
            'title': 'Change',
            'text': '\n'.join(change)
        })

    if replacements:
        attachments.append({
            'color': '#FFC0CB',
            'title': 'Replacements',
            'text': '\n'.join(replacements)
        })

    text = 'Commit <https://github.com/khalid-gh/' + os.getenv('REPO_NAME') + '/commit/' + os.getenv('COMMIT_SHA') + '|' + os.getenv('SHORT_SHA') + '> has changes that need applying, view the full plan <https://console.cloud.google.com/cloud-build/builds/' + os.getenv('BUILD_ID') + '?project=' + os.getenv('PROJECT_ID') + '|here>\nTo apply run `gcloud builds submit --config ' + os.getenv('TERRAFORM_FOLDER') + '/cloudbuild-apply.yml --project ' + os.getenv('PROJECT_ID') + ' gs://' + os.getenv('PLAN_BUCKET') + '/' + os.getenv('BUILD_ID') + '/tfplan.tar.gz`'
    print(text)

    message = {
        'channel': os.getenv('SLACK_CHANNEL'),
        'icon_emoji': ':terraform:',
        'username': 'Terraform ' + os.getenv('REPO_NAME') + '/' + os.getenv('TERRAFORM_FOLDER'),
        'text': text,
        'attachments': attachments
    }
    data = json.dumps(message).encode('utf-8')
    headers = {'Content-Type': 'application/json'}
    try:
        urllib.request.urlopen(urllib.request.Request(os.getenv('SLACK_WEBHOOK'), data=data, headers=headers))
    except urllib.error.HTTPError as e:
        print(e.read().decode('utf-8'))
        raise e


if __name__ == '__main__':
    plan = json.loads(subprocess.check_output(['terraform', 'show', '-json', 'tfplan']).decode('utf-8'))

    add = []
    destroy = []
    change = []
    replacements = []
    for rc in plan['resource_changes']:
        if rc['change']['actions'] == ['create']:
            add.append(rc['address'])
        elif rc['change']['actions'] == ['delete']:
            destroy.append(rc['address'])
        elif rc['change']['actions'] == ['update']:
            change.append(rc['address'])
        elif rc['change']['actions'] == ['delete', 'create']:
            replacements.append(rc['address'])

    if add or destroy or change or replacements:
        print('Changes detected in plan, copying to GCS and sending Slack alert')

        subprocess.check_call(['tar', '-zcvf', '../tfplan.tar.gz', '.'])
        subprocess.check_call(['gsutil', 'cp', '../tfplan.tar.gz', 'gs://' + os.getenv('PLAN_BUCKET') + '/' + os.getenv('BUILD_ID') + '/tfplan.tar.gz'])

        slack_alert(add, destroy, change, replacements)
    else:
        print('No changes detected in plan')