resource "google_kms_key_ring" "terraform" {
  name     = "terraform"
  location = var.region
}

resource "google_kms_crypto_key" "terraform" {
  name     = "terraform"
  key_ring = google_kms_key_ring.terraform.id
}

data "google_kms_secret" "slack-webhook" {
  crypto_key = google_kms_crypto_key.terraform.id
  ciphertext = var.slack_webhook
}