module "wayfinder_cloudaccess" {
  source = "../../"

  resource_suffix                        = "app1-np"
  wayfinder_identity_gcp_service_account = "wf-management@wayfinder-host-project.iam.gserviceaccount.com"
  enable_cluster_manager                 = true
  enable_dns_zone_manager                = true
  enable_network_manager                 = true
  enable_cloud_info                      = false
}
