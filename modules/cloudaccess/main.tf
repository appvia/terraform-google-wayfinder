locals {
  resource_prefix = "wf"
  resource_suffix = var.resource_suffix

  # populate the account ID and role name if from the irsa role arn using split
  aws_account_id = var.from_aws ? split(":", var.wayfinder_identity_aws_role_arn)[4] : ""
  aws_role_name  = var.from_aws ? split("role/", var.wayfinder_identity_aws_role_arn)[1] : ""

  # Service account IDs (limit to 29 chars, no hyphens)
  serviceaccount_id = substr(replace(lower("${local.resource_prefix}wayfinder${local.resource_suffix}"), "-", ""), 0, 29)

  # Role IDs (limit to 63 chars, no hyphens)
  clustermgr_role_id = substr(replace(lower("${local.resource_prefix}clustermgr${local.resource_suffix}"), "-", ""), 0, 63)
  networkmgr_role_id = substr(replace(lower("${local.resource_prefix}networkmgr${local.resource_suffix}"), "-", ""), 0, 63)
  peeraccpt_role_id  = substr(replace(lower("${local.resource_prefix}peeraccpt${local.resource_suffix}"), "-", ""), 0, 63)
  cloudinfo_role_id  = substr(replace(lower("${local.resource_prefix}cloudinfo${local.resource_suffix}"), "-", ""), 0, 63)
  custom_role_id     = substr(replace(lower("${local.resource_prefix}wayfinder${local.resource_suffix}"), "-", ""), 0, 63)
}

data "google_project" "project" {}

data "google_service_account" "wayfinder" {
  count = var.from_gcp ? 1 : 0

  account_id = var.wayfinder_identity_gcp_service_account
}

resource "google_project_service" "compute_api" {
  count              = var.enable_cluster_manager_permissions ? 1 : 0
  disable_on_destroy = false
  project            = data.google_project.project.project_id
  service            = "compute.googleapis.com"
}

resource "google_project_service" "container_api" {
  count              = var.enable_cluster_manager_permissions ? 1 : 0
  disable_on_destroy = false
  project            = data.google_project.project.project_id
  service            = "container.googleapis.com"
}

resource "google_project_service" "cloud_resource_manager_api" {
  disable_on_destroy = false
  project            = data.google_project.project.project_id
  service            = "cloudresourcemanager.googleapis.com"
}

resource "google_project_service" "iam_credentials_api" {
  disable_on_destroy = false
  project            = data.google_project.project.project_id
  service            = "iamcredentials.googleapis.com"
}
