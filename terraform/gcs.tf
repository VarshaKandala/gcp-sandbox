resource "google_storage_bucket" "tfstate" {
  name                        = "${var.project}-tfstate"
  location                    = var.region
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true

  versioning {
    enabled = true
  }
}

resource "google_storage_bucket" "tfplan" {
  name                        = "${var.project}-tfplan"
  location                    = var.region
  storage_class               = "REGIONAL"
  uniform_bucket_level_access = true

  lifecycle_rule {
    action {
      type = "Delete"
    }

    condition {
      age = 7
    }
  }
}

resource "google_storage_bucket" "permissions-test-bucket" {
  name                        = "permissions-test-bucket-khalid"
  location                    = var.region
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true

  versioning {
    enabled = true
  }
}
