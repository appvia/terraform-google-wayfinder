resource "google_service_account" "cloudresourcesprov" {
  count = var.enable_cloud_resource_provisioning ? 1 : 0

  account_id   = "${local.resource_prefix}cloudresourcesprov${local.resource_suffix}"
  display_name = "Cloud Resource Provisioning"
}

resource "google_service_account_iam_member" "cloudresourcesprov" {
  count = var.enable_cloud_info && (var.from_gcp) ? 1 : 0

  service_account_id = google_service_account.cloudresourcesprov[0].name
  role               = "roles/iam.serviceAccountTokenCreator"
  member             = data.google_service_account.wayfinder[0].member
}

resource "google_service_account_iam_member" "cloudresprovfederated" {
  count = var.enable_cloud_resource_provisioning && (var.from_aws || var.from_azure) ? 1 : 0

  service_account_id = google_service_account.cloudresourcesprov[0].name
  role               = "roles/iam.serviceAccountTokenCreator"

  # we should possibly make this more specific (although our pool already limits to the correct IRSA role)
  member = "principalSet://iam.googleapis.com/projects/${data.google_project.project.number}/locations/global/workloadIdentityPools/${google_iam_workload_identity_pool.federated[0].workload_identity_pool_id}/*"
}
