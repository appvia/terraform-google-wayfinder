output "cluster_manager_service_account" {
  description = "Email of Cluster Manager service account to use as spec.permissions[].gcpServiceAccount on the ClusterManager permission of your cloud access config"
  value       = join("", google_service_account.clustermanager.*.email)
}

output "dns_zone_manager_service_account" {
  description = "Email of DNS Zone Manager service account to use as spec.permissions[].gcpServiceAccount on the DNSZoneManager permission of your cloud access config"
  value       = join("", google_service_account.dnszonemanager.*.email)
}

output "network_manager_service_account" {
  description = "Email of Network Manager service account to use as spec.permissions[].gcpServiceAccount on the NetworkManager permission of your cloud access config"
  value       = join("", google_service_account.networkmanager.*.email)
}

output "cloud_info_service_account" {
  description = "Email of Cloud Info service account to use as spec.permissions[].gcpServiceAccount on the CloudInfo permission of your cloud access config"
  value       = join("", google_service_account.cloudinfo.*.email)
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
  value       = join("", google_iam_workload_identity_pool.federated.*.workload_identity_pool_id)
}

output "gcp_workload_identity_provider_id" {
  description = "ID of GCP Workload Identity Provider to use as spec.gcp.workloadIdentityProviderID of your cloud access config when enabling cross-cloud access to GCP from AWS or Azure"
  # only one of these is possible, so we can just join them
  value = join("", google_iam_workload_identity_pool_provider.aws_federated.*.workload_identity_pool_provider_id, google_iam_workload_identity_pool_provider.azure_federated.*.workload_identity_pool_provider_id)
}
