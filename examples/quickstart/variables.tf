variable "region" {
  description = "Google Cloud region"
  type        = string
}

variable "gcp_project" {
  description = "Google Cloud Project ID"
  type        = string
}

variable "clusterissuer_email" {
  description = "The email address to use for the cert-manager cluster issuer."
  type        = string
}

variable "wayfinder_domain_name_ui" {
  description = "The local DNS host to use for Wayfinder Portal."
  type        = string
}

variable "wayfinder_domain_name_api" {
  description = "The local DNS host to use for Wayfinder API."
  type        = string
}

variable "environment" {
  description = "The environment name we are provisioning."
  type        = string
  default     = "production"
}

variable "wayfinder_instance_id" {
  description = "The instance ID to use for Wayfinder."
  type        = string
}

variable "wayfinder_licence_key" {
  description = "The licence key to use for Wayfinder."
  type        = string
  sensitive   = true
}
