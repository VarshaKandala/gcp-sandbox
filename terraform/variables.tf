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
  default     = "CiQAeCmglnITVTMBsT/hi8aw27n3nLPDsehKXgkoKBy20DFEDcYSeQAeEE6rMpsj+lQSrDo9glvcZcxYtG8fcaLlSUgYdMyVSw8L2Iyd/zQK2rGgoBXX2dvjW8WqKjUwgzi1Pi2Zwle8Mbtf0gFpszpmRJJBziLB7nQluIzmCuuMvqRAKSvTVCvx8PY0kv0DVvU/G9ekTXbIPPOVT4nahHw="
}