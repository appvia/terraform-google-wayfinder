variable "from_aws" {
  default     = false
  description = "Whether Wayfinder is running on AWS."
  type        = bool
}

variable "from_azure" {
  default     = true
  description = "Whether Wayfinder is running on Azure."
  type        = bool
}

variable "from_gcp" {
  default     = false
  description = "Whether Wayfinder is running on GCP."
  type        = bool
}

variable "resource_suffix" {
  default     = ""
  description = "Suffix to apply to all generated resources. We recommend using workspace key + stage."
  type        = string
}

variable "wayfinder_identity_gcp_service_account" {
  default     = ""
  description = "Email address of Wayfinder's GCP service account to give access to. Populate when Wayfinder is running on GCP with Workload Identity."
  type        = string
}

variable "wayfinder_identity_azure_client_id" {
  default     = ""
  description = "Client ID of Wayfinder's Azure AD managed identity to give access to. Populate when Wayfinder is running on Azure with AzureAD Workload Identity."
  type        = string
}

variable "wayfinder_identity_azure_tenant_id" {
  default     = ""
  description = "Tenant ID of Wayfinder's Azure AD managed identity to give access to. Populate when Wayfinder is running on Azure with AzureAD Workload Identity."
  type        = string
}

variable "wayfinder_identity_aws_role_arn" {
  default     = ""
  description = "ARN of Wayfinder's identity to give access to. Populate when Wayfinder is running on AWS with IRSA."
  type        = string
}

variable "enable_cluster_manager" {
  default     = true
  description = "Whether to create the Cluster Manager service account"
  type        = bool
}

variable "enable_dns_zone_manager" {
  default     = true
  description = "Whether to create the DNS Zone Manager service account"
  type        = bool
}

variable "enable_network_manager" {
  default     = true
  description = "Whether to create the Network Manager service account"
  type        = bool
}

variable "enable_peering_acceptor" {
  default     = false
  description = "Whether to create the Peering Acceptor service account"
  type        = bool
}

variable "enable_cloud_info" {
  default     = false
  description = "Whether to create the Cloud Info service account"
  type        = bool
}
