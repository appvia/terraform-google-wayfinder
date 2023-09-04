/**
 * Copyright 2018 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

variable "project_id" {
  description = "The project ID of your project"
}
variable "cluster_name" {
  description = "The name for the GKE cluster"
  default     = "gke-terraform-wayfinder"
}
variable "env_name" {
  description = "The environment for the GKE cluster"
  default     = "wayfinder-demo"
}
variable "region" {
  description = "The region to host the cluster in"
  default     = "europe-west2"
}
variable "zones" {
  description = "Cluster zone"
  default     = "europe-west2-a"
}
variable "network" {
  description = "The VPC network created to host the cluster in"
  default     = "gke-network"
}
variable "subnetwork" {
  description = "The subnetwork created to host the cluster in"
  default     = "gke-subnet"
}

variable "ip_range_pods_name" {
  description = "The secondary ip range to use for pods"
  default     = "ip-range-pods"
}

variable "ip_range_services_name" {
  description = "The secondary ip range to use for services"
  default     = "ip-range-services"
}

variable "service-account-id" {
  description = "The ID of service account of GCP"
  default     = "serviceaccount-id"
}

variable "cpus" {
  description = "Number of cpus"
  default     = "2"
}


variable "minnode" {
  description = "Minimum number of node pool"
  default     = 1
}
variable "maxnode" {
  description = "Maximum number of node pool"
  default     = 2
}

variable "disksize" {
  description = "Disk Size in GB"
  default     = 10
}


variable "cluster_autoscaling" {
  type = object({
    enabled             = bool
    autoscaling_profile = string
    min_cpu_cores       = number
    max_cpu_cores       = number
    min_memory_gb       = number
    max_memory_gb       = number
    gpu_resources = list(object({
      resource_type = string
      minimum       = number
      maximum       = number
    }))
    auto_repair  = bool
    auto_upgrade = bool
  })
  default = {
    enabled             = false
    autoscaling_profile = "BALANCED"
    max_cpu_cores       = 0
    min_cpu_cores       = 0
    max_memory_gb       = 0
    min_memory_gb       = 0
    gpu_resources       = []
    auto_repair         = true
    auto_upgrade        = true
  }
  description = "Cluster autoscaling configuration. See [more details](https://cloud.google.com/kubernetes-engine/docs/reference/rest/v1beta1/projects.locations.clusters#clusterautoscaling)"
}


variable "enable_k8s_resources" {
  description = "Whether to enable the creation of Kubernetes resources for Wayfinder (helm and kubectl manifest deployments)"
  type        = bool
  default     = true
}

variable "clusterissuer_email" {
  description = "The email address to use for the cert-manager cluster issuer."
  type        = string
  default     = "adekunle.ibitayo@appvia.io"
}


variable "wayfinder_instance_id" {
  description = "The instance ID to use for Wayfinder. This can be left blank and will be autogenerated."
  type        = string
  default     = "test-wayfinder"
}

variable "wayfinder_domain_name_api" {
  description = "The domain name to use for the Wayfinder API (e.g. api.wayfinder.example.com)"
  type        = string
  default     = "api.wayfinder.example.com"

}

variable "wayfinder_domain_name_ui" {
  description = "The domain name to use for the Wayfinder UI (e.g. portal.wayfinder.example.com)"
  type        = string
  default     = "portal.wayfinder.example.com"

}

variable "wayfinder_license_key" {
  description = "The license key to use for Wayfinder"
  type        = string
  sensitive   = true
}

variable "wayfinder_release_channel" {
  description = "The release channel to use for Wayfinder"
  type        = string
  default     = "wayfinder-releases"
}

variable "wayfinder_version" {
  description = "The version to use for Wayfinder"
  type        = string
  default     = "v2.2.1"
}