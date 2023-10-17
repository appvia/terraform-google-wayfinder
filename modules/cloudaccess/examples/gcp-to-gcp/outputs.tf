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
