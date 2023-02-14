resource "google_cloudbuild_trigger" "terraform" {
  provider = google-beta

  name        = "terraform"
  description = "Push to master branch terraform folder"

  github {
    owner = "VarshaKandala"
    name  = "gcp-sandbox"

    push {
      branch = "^main$"
    }
  }

  included_files = [
    "terraform/**",
  ]

  substitutions = {
    _SLACK_WEBHOOK = data.google_kms_secret.slack-webhook.plaintext
  }

  build {
    step {
      name       = "gcr.io/cloud-builders/gcloud"
      entrypoint = "/bin/bash"

      args = [
        "-ce",

        <<-EOF
        cd terraform
        gsutil cp gs://ons-gcr-binaries/terraform-1.1.4 /usr/bin/terraform
        chmod 755 /usr/bin/terraform
        terraform init -backend-config=bucket=$PROJECT_ID-tfstate
        terraform plan -out tfplan
        python3 -u ../plan-changes.py
        EOF
      ]

      env = [
        "SLACK_CHANNEL=#builds",
        "SLACK_WEBHOOK=$_SLACK_WEBHOOK",
        "PROJECT_ID=$PROJECT_ID",
        "PLAN_BUCKET=$PROJECT_ID-tfplan",
        "BUILD_ID=$BUILD_ID",
        "REPO_NAME=$REPO_NAME",
        "TERRAFORM_FOLDER=.",
        "COMMIT_SHA=$COMMIT_SHA",
        "SHORT_SHA=$SHORT_SHA",
      ]
    }
  }
}

resource "google_cloudbuild_trigger" "terraform-pr" {
  provider = google-beta

  name        = "terraform-pr"
  description = "PR terraform folder"

  github {
    owner = "VarshaKandala"
    name  = "gcp-sandbox"

    pull_request {
      branch = ".*"
    }
  }

  included_files = [
    "terraform/**",
  ]

  build {
    step {
      name       = "gcr.io/cloud-builders/gcloud"
      entrypoint = "/bin/bash"

      args = [
        "-ce",

        <<-EOF
        cd terraform
        gsutil cp gs://ons-gcr-binaries/terraform-1.1.4 /usr/bin/terraform
        chmod 755 /usr/bin/terraform
        terraform init -backend-config=bucket=$PROJECT_ID-tfstate
        terraform plan -lock=false
        EOF
      ]
    }
  }
}