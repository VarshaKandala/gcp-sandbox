resource "google_project_service" "notebooks" {
  provider           = google
  service            = "notebooks.googleapis.com"
  disable_on_destroy = false
}

resource "google_notebooks_instance" "basic_instance" {
  project      = "varsha-test"
  name         = "varsha-notebook"
  provider     = google
  location     = "eu-west2-a"
  machine_type = "n1-standard-1"

  vm_image {
    project      = "deeplearning-platform-release"
    image_family = "r-latest-cpu-experimental"
  }

  depends_on = [
    google_project_service.notebooks
  ]
}