output "cluster_manager_service_account" {
  description = "Email of Cluster Manager service account to use as spec.permissions[].gcpServiceAccount on the ClusterManager permission of your cloud access config"
  value       = var.enable_cluster_manager ? google_service_account.clustermanager[0].email : null
}

output "dns_zone_manager_service_account" {
  description = "Email of DNS Zone Manager service account to use as spec.permissions[].gcpServiceAccount on the DNSZoneManager permission of your cloud access config"
  value       = var.enable_dns_zone_manager ? google_service_account.dnszonemanager[0].email : null
}

output "network_manager_service_account" {
  description = "Email of Network Manager service account to use as spec.permissions[].gcpServiceAccount on the NetworkManager permission of your cloud access config"
  value       = var.enable_network_manager ? google_service_account.networkmanager[0].email : null
}

output "cloud_info_service_account" {
  description = "Email of Cloud Info service account to use as spec.permissions[].gcpServiceAccount on the CloudInfo permission of your cloud access config"
  value       = var.enable_cloud_info ? google_service_account.cloudinfo[0].email : null
}

output "gcp_projectnumber" {
  description = "Project Number of the GCP project to use as spec.gcp.projectNumber of your cloud access config when enabling cross-cloud access to GCP from AWS or Azure"
  value       = data.google_project.project.number
}

output "gcp_project" {
  description = "Project Name of the GCP project to use as spec.gcp.project of your cloud access config"
  value       = data.google_project.project.name
}

output "gcp_workload_identity_pool_id" {
  description = "ID of GCP Workload Identity Pool to use as spec.gcp.workloadIdentityPoolID of your cloud access config when enabling cross-cloud access to GCP from AWS or Azure"
  value       = (var.from_aws || var.from_azure) ? google_iam_workload_identity_pool.federated[0].workload_identity_pool_id : null
}

output "gcp_workload_identity_provider_id_aws" {
  description = "ID of GCP Workload Identity Provider to use as spec.gcp.workloadIdentityProviderID of your cloud access config when enabling cross-cloud access to GCP from AWS"
  value       = var.from_aws ? google_iam_workload_identity_pool_provider.aws_federated[0].workload_identity_pool_provider_id : null
}
output "gcp_workload_identity_provider_id_azure" {
  description = "ID of GCP Workload Identity Provider to use as spec.gcp.workloadIdentityProviderID of your cloud access config when enabling cross-cloud access to GCP from Azure"
  value       = var.from_azure ? google_iam_workload_identity_pool_provider.azure_federated[0].workload_identity_pool_provider_id : null
}
