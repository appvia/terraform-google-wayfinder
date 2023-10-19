locals {
  resource_prefix = "wf"
  resource_suffix = var.resource_suffix

  # populate the account ID and role name if from the irsa role arn using split
  aws_account_id = var.wayfinder_identity_aws_role_arn != "" ? split(":", var.wayfinder_identity_aws_role_arn)[4] : ""
  aws_role_name  = var.wayfinder_identity_aws_role_arn != "" ? split("role/", var.wayfinder_identity_aws_role_arn)[1] : ""

  create_aws_trust   = var.wayfinder_identity_aws_role_arn != "" ? true : false
  create_azure_trust = var.wayfinder_identity_azure_client_id != "" ? true : false
}

data "google_project" "project" {}

data "google_service_account" "wayfinder" {
  count = var.wayfinder_identity_gcp_service_account != "" ? 1 : 0

  account_id = var.wayfinder_identity_gcp_service_account
}
