module "wayfinder_cloudaccess" {
  source = "github.com/appvia/terraform-google-wayfinder//modules/cloudaccess"

  resource_suffix = var.resource_suffix
  region          = var.region

  wayfinder_identity_gcp_service_account = var.wayfinder_identity_gcp_service_account
  wayfinder_identity_aws_role_arn        = var.wayfinder_identity_aws_role_arn
  wayfinder_identity_azure_client_id     = var.wayfinder_identity_client_principal_id
  wayfinder_identity_azure_tenant_id     = var.wayfinder_identity_client_tenant_id

  enable_cluster_manager  = var.enable_cluster_manager
  enable_dns_zone_manager = var.enable_dns_zone_manager
  enable_network_manager  = var.enable_network_manager
  enable_cloud_info       = var.enable_cloud_info

  from_aws   = var.from_aws
  from_azure = var.from_azure
  from_gcp   = var.from_gcp
}
