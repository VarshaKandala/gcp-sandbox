terraform {
  required_version = "1.1.4"

  backend "gcs" {
    bucket = "varsha-test-tfstate"
  }

  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
}

provider "google" {
  project = var.project
  region  = var.region
}

provider "google-beta" {
  project = var.project
  region  = var.region
}