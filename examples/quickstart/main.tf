module "wayfinder" {
  source = "../../"

  clusterissuer_email            = var.clusterissuer_email
  create_localadmin_user         = true
  disable_internet_access        = var.disable_internet_access
  environment                    = var.environment
  gcp_network_name               = module.network.network_name
  gcp_project                    = var.gcp_project
  gcp_region                     = var.gcp_region
  gcp_subnetwork_name            = module.network.subnets[join("/", [var.gcp_region, "compute"])].name
  labels                         = var.labels
  pods_subnetwork_range_name     = "pods"
  services_subnetwork_range_name = "services"
  wayfinder_domain_name_api      = var.wayfinder_domain_name_api
  wayfinder_domain_name_ui       = var.wayfinder_domain_name_ui
  wayfinder_instance_id          = var.wayfinder_instance_id
  wayfinder_licence_key          = var.wayfinder_licence_key
}
