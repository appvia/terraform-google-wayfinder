resource "google_service_account" "cloudinfo" {
  count = var.enable_cloud_info ? 1 : 0

  account_id   = "${local.resource_prefix}cloudinfo${local.resource_suffix}"
  display_name = "Cloud Info metadata"
}

resource "google_project_iam_member" "cloudinfo" {
  count = var.enable_cloud_info ? 1 : 0

  project = data.google_project.project.id
  role    = google_project_iam_custom_role.cloudinfo[0].name
  member  = google_service_account.cloudinfo[0].member
}

resource "google_project_iam_custom_role" "cloudinfo" {
  count       = var.enable_cloud_info ? 1 : 0
  role_id     = "${local.resource_prefix}cloudinfo${local.resource_suffix}"
  title       = "Cloud Info"
  description = "Permissions for wayfinder to retrieve pricing and instance type metadata"
  permissions = [
    "compute.machineTypes.list",
    "compute.regions.list",
    "resourcemanager.projects.get",
  ]
}

resource "google_service_account_iam_member" "cloudinfo" {
  # only create when we have a GCP service account and are NOT using a federated access
  count = var.enable_cloud_info && (var.from_gcp) ? 1 : 0

  service_account_id = google_service_account.cloudinfo[0].name
  role               = "roles/iam.serviceAccountTokenCreator"
  member             = data.google_service_account.wayfinder[0].member
}

resource "google_service_account_iam_member" "cloudinfofederated" {
  count = var.enable_cloud_info && (var.from_aws || var.from_azure) ? 1 : 0

  service_account_id = google_service_account.cloudinfo[0].name
  role               = "roles/iam.serviceAccountTokenCreator"

  # we should possibly make this more specific (although our pool already limits to the correct IRSA role)
  member = "principalSet://iam.googleapis.com/projects/${data.google_project.project.number}/locations/global/workloadIdentityPools/${google_iam_workload_identity_pool.federated[0].workload_identity_pool_id}/*"
}
