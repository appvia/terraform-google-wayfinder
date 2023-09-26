variable "clusterissuer_email" {
  description = "The email address to use for the cert-manager cluster issuer."
  type        = string
}

variable "disable_internet_access" {
  description = "Whether to disable internet access for EKS and the Wayfinder ingress controller."
  type        = bool
  default     = false
}

variable "environment" {
  description = "The environment name we are provisioning."
  type        = string
  default     = "production"
}

variable "gcp_project" {
  description = "Google Cloud Platform Project ID."
  type        = string
}

variable "gcp_region" {
  description = "Google Cloud region."
  type        = string
  default     = "europe-west2"
}

variable "labels" {
  description = "A map of labels to add to all resources created."
  type        = map(string)
  default     = {}
}

variable "wayfinder_domain_name_ui" {
  description = "The local DNS host to use for Wayfinder Portal."
  type        = string
}

variable "wayfinder_domain_name_api" {
  description = "The local DNS host to use for Wayfinder API."
  type        = string
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
