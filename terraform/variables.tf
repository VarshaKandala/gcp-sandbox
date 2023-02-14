variable "project" {
  type        = string
  description = "The GCP project"
  default     = "varsha-test"
}

variable "region" {
  type        = string
  description = "Region for resources to deploy to"
  default     = "europe-west2"
}

variable "slack_webhook" {
  type        = string
  description = "Ciphertext for the slack webhook"
  default     = "CiQAhZWevf/3z6v1bN5cAStgwnSSGBuVZdXPnwUoHXfxQmjCyiQSegBNe+iRxhEBjKuWjOLzXTF0qbNA1PXOkgGTHnLSwXtRW9NndGwMF9dhfp9VfWhuLlX+E70pyl2oJFEWFRExbHAz9THhLqD+AgqdtVhgkKbI0keN8S3wRLxXRpnXMIFfXs+W3u9tken83AmBJ/K67Ui1BumLV2GaVeKo"
}