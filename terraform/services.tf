module "project-services" {
  source  = "terraform-google-modules/project-factory/google//modules/project_services"
  version = "~> 14.1"

  project_id = var.project

  activate_apis = [
    "compute.googleapis.com",
    "iam.googleapis.com",
    "iamcredentials.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "cloudbilling.googleapis.com",
    "pubsub.googleapis.com",
    "storage.googleapis.com",
    "cloudkms.googleapis.com",
    "logging.googleapis.com",
    "deploymentmanager.googleapis.com",
    "cloudbuild.googleapis.com",
    "cloudfunctions.googleapis.com",
    "iap.googleapis.com",
    "serviceusage.googleapis.com",
    "monitoring.googleapis.com",
    "admin.googleapis.com",
    "osconfig.googleapis.com",
  ]
}