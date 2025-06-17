variable "from_aws" {
  default     = false
  description = "Whether Wayfinder is running on AWS."
  type        = bool
}

variable "from_azure" {
  default     = false
  description = "Whether Wayfinder is running on Azure."
  type        = bool
}

variable "from_gcp" {
  default     = true
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

variable "enable_cluster_manager_permissions" {
  default     = false
  description = "Whether to grant Cluster Manager permissions to the service account"
  type        = bool
}

variable "enable_dns_zone_manager_permissions" {
  default     = false
  description = "Whether to grant DNS Zone Manager permissions to the service account"
  type        = bool
}

variable "enable_network_manager_permissions" {
  default     = false
  description = "Whether to grant Network Manager permissions to the service account"
  type        = bool
}

variable "enable_peering_acceptor_permissions" {
  default     = false
  description = "Whether to grant Peering Acceptor permissions to the service account"
  type        = bool
}

variable "enable_cloud_info_permissions" {
  default     = false
  description = "Whether to grant Cloud Info permissions to the service account"
  type        = bool
}

variable "custom_role_ids" {
  default     = []
  description = "List of custom roles to bind to the service account"
  type        = list(string)
}

variable "custom_permissions" {
  default     = []
  description = "List of permissions to add to the service account"
  type        = list(string)
}

