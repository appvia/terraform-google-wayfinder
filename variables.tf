variable "clusterissuer_email" {
  description = "The email address to use for the cert-manager cluster issuer."
  type        = string
}

variable "cluster_endpoint_public_access_cidrs" {
  description = "List of CIDR blocks which can access the GKE API master endpoint."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "create_localadmin_user" {
  description = "Whether to create a localadmin user for access to the Wayfinder Portal and API."
  type        = bool
  default     = true
}

variable "disable_internet_access" {
  description = "Whether to disable internet access for GKE and the Wayfinder ingress controller."
  type        = bool
  default     = false
}

variable "disable_local_login" {
  description = "Whether to disable local login for Wayfinder. Note: An IDP must be configured within Wayfinder, otherwise you will not be able to log in."
  type        = bool
  default     = false
}

variable "enable_k8s_resources" {
  description = "Whether to enable the creation of Kubernetes resources for Wayfinder (helm and kubectl manifest deployments)."
  type        = bool
  default     = true
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
}

variable "gcp_network_name" {
  description = "Google Compute Engine network to which the cluster is connected."
  type        = string
}

variable "gcp_subnetwork_name" {
  description = "The name or self_link of the Google Compute Engine subnetwork in which the cluster's instances are launched."
  type        = string
}

variable "gke_nodes_machine_type" {
  description = "The instance types to use for the GKE managed node pool."
  type        = string
  default     = "e2-medium"
}

variable "gke_nodes_minimum_size" {
  description = "The minimum size to use for the GKE managed node pool."
  type        = number
  default     = 2
}

variable "gke_release_channel" {
  description = "The release channel to use for GKE."
  type        = string
  default     = "UNSPECIFIED"
}

variable "labels" {
  description = "A map of labels to add to all resources created."
  type        = map(string)
  default     = {}
}

variable "pods_subnetwork_range_name" {
  description = "The name of the existing secondary range in the cluster's subnetwork to use for pod IP addresses."
  type        = string
}

variable "services_subnetwork_range_name" {
  description = "The name of the existing secondary range in the cluster's subnetwork to use for services IP addresses."
  type        = string
}

variable "wayfinder_domain_name_api" {
  description = "The domain name to use for the Wayfinder API (e.g. api.wayfinder.example.com)."
  type        = string
}

variable "wayfinder_domain_name_ui" {
  description = "The domain name to use for the Wayfinder UI (e.g. portal.wayfinder.example.com)."
  type        = string
}

variable "wayfinder_idp_details" {
  description = "The IDP details to use for Wayfinder to enable SSO."
  type = object({
    type          = string
    clientId      = optional(string)
    clientSecret  = optional(string)
    serverUrl     = optional(string)
    azureTenantId = optional(string)
  })

  sensitive = true

  validation {
    condition     = contains(["generic", "aad", "none"], var.wayfinder_idp_details["type"])
    error_message = "wayfinder_idp_details[\"type\"] must be one of: generic, aad, none"
  }

  validation {
    condition     = var.wayfinder_idp_details["type"] == "none" || (var.wayfinder_idp_details["type"] == "generic" && length(var.wayfinder_idp_details["serverUrl"]) > 0) || (var.wayfinder_idp_details["type"] == "aad" && length(var.wayfinder_idp_details["azureTenantId"]) > 0)
    error_message = "serverUrl must be set if IDP type is generic, azureTenantId must be set if IDP type is aad"
  }

  default = {
    type          = "none"
    clientId      = null
    clientSecret  = null
    serverUrl     = ""
    azureTenantId = ""
  }
}

variable "wayfinder_instance_id" {
  description = "The instance ID to use for Wayfinder."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9]{20}$", var.wayfinder_instance_id))
    error_message = "The Wayfinder Instance ID must be alphanumeric and 20 characters long."
  }
}

variable "wayfinder_licence_key" {
  description = "The licence key to use for Wayfinder."
  type        = string
  sensitive   = true
}

variable "wayfinder_release_channel" {
  description = "The release channel to use for Wayfinder."
  type        = string
  default     = "wayfinder-releases"
}

variable "wayfinder_version" {
  description = "The version to use for Wayfinder."
  type        = string
  default     = "v2.3.3"
}
