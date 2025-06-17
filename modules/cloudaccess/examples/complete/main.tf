module "wayfinder_cloudaccess" {
  source = "github.com/appvia/terraform-google-wayfinder//modules/cloudaccess?ref=v3"

  resource_suffix = var.resource_suffix

  wayfinder_identity_gcp_service_account = var.wayfinder_identity_gcp_service_account
  wayfinder_identity_aws_role_arn        = var.wayfinder_identity_aws_role_arn
  wayfinder_identity_azure_client_id     = var.wayfinder_identity_azure_client_id
  wayfinder_identity_azure_tenant_id     = var.wayfinder_identity_azure_tenant_id

  enable_cluster_manager_permissions  = var.enable_cluster_manager_permissions
  enable_dns_zone_manager_permissions = var.enable_dns_zone_manager_permissions
  enable_network_manager_permissions  = var.enable_network_manager_permissions
  enable_peering_acceptor_permissions = var.enable_peering_acceptor_permissions
  enable_cloud_info_permissions       = var.enable_cloud_info_permissions

  custom_role_ids    = var.custom_role_ids
  custom_permissions = var.custom_permissions

  from_aws   = var.from_aws
  from_azure = var.from_azure
  from_gcp   = var.from_gcp
}
