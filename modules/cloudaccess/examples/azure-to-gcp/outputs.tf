output "cluster_manager_service_account" {
  value = module.wayfinder_cloudaccess.cluster_manager_service_account
}

output "dns_zone_manager_service_account" {
  value = module.wayfinder_cloudaccess.dns_zone_manager_service_account
}

output "network_manager_service_account" {
  value = module.wayfinder_cloudaccess.network_manager_service_account
}

output "cloud_info_service_account" {
  value = module.wayfinder_cloudaccess.cloud_info_service_account
}

output "gcp_project" {
  value = module.wayfinder_cloudaccess.gcp_project
}

output "gcp_projectnumber" {
  value = module.wayfinder_cloudaccess.gcp_projectnumber
}

output "gcp_workload_identity_pool_id" {
  value = module.wayfinder_cloudaccess.gcp_workload_identity_pool_id
}

output "gcp_workload_identity_provider_id" {
  value = module.wayfinder_cloudaccess.gcp_workload_identity_provider_id
}
