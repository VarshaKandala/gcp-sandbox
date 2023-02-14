# gcp-sandbox

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.1.4 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.53.0 |
| <a name="provider_google-beta"></a> [google-beta](#provider\_google-beta) | 4.53.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_project-services"></a> [project-services](#module\_project-services) | terraform-google-modules/project-factory/google//modules/project_services | ~> 14.1 |

## Resources

| Name | Type |
|------|------|
| [google-beta_google_cloudbuild_trigger.terraform](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_cloudbuild_trigger) | resource |
| [google-beta_google_cloudbuild_trigger.terraform-pr](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_cloudbuild_trigger) | resource |
| [google_kms_crypto_key.terraform](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_crypto_key) | resource |
| [google_kms_key_ring.terraform](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_key_ring) | resource |
| [google_storage_bucket.tfplan](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket) | resource |
| [google_storage_bucket.tfstate](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket) | resource |
| [google_kms_secret.slack-webhook](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/kms_secret) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_project"></a> [project](#input\_project) | The GCP project | `string` | `"varsha-test"` | no |
| <a name="input_region"></a> [region](#input\_region) | Region for resources to deploy to | `string` | `"europe-west2"` | no |
| <a name="input_slack_webhook"></a> [slack\_webhook](#input\_slack\_webhook) | Ciphertext for the slack webhook | `string` | `"CiQAhZWevf/3z6v1bN5cAStgwnSSGBuVZdXPnwUoHXfxQmjCyiQSegBNe+iRxhEBjKuWjOLzXTF0qbNA1PXOkgGTHnLSwXtRW9NndGwMF9dhfp9VfWhuLlX+E70pyl2oJFEWFRExbHAz9THhLqD+AgqdtVhgkKbI0keN8S3wRLxXRpnXMIFfXs+W3u9tken83AmBJ/K67Ui1BumLV2GaVeKo"` | no |

## Outputs

No outputs.

## Secrets

The slack webhook is stored encrypted in [secrets.txt.enc](secrets.txt.enc). It can be decrypted by running the following command:

```shell
cat secrets.txt.enc | base64 -d | gcloud kms decrypt --project varsha-test --location europe-west2 --keyring terraform --key terraform --plaintext-file - --ciphertext-file -
```
