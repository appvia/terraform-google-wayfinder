resource "google_service_account" "clustermanager" {
  count = var.enable_cluster_manager ? 1 : 0

  account_id   = "${local.resource_prefix}clustermgr${local.resource_suffix}"
  display_name = "Cluster Manager"
}

resource "google_project_iam_member" "clustermanager" {
  count = var.enable_cluster_manager ? 1 : 0

  project = data.google_project.project.id
  role    = "roles/owner"
  member  = google_service_account.clustermanager[0].member
}

resource "google_service_account_iam_member" "clustermanager" {
  count = var.enable_cluster_manager && (var.wayfinder_identity_gcp_service_account != "") ? 1 : 0

  service_account_id = google_service_account.clustermanager[0].name
  role               = "roles/iam.serviceAccountTokenCreator"
  member             = data.google_service_account.wayfinder[0].member
}

resource "google_service_account_iam_member" "clustermanagerfederated" {
  count = var.enable_cluster_manager && (local.create_aws_trust || local.create_azure_trust) ? 1 : 0

  service_account_id = google_service_account.clustermanager[0].name
  role               = "roles/iam.serviceAccountTokenCreator"

  # we should possibly make this more specific (although our pool already limits to the correct IRSA role)
  member = "principalSet://iam.googleapis.com/projects/${data.google_project.project.number}/locations/global/workloadIdentityPools/${google_iam_workload_identity_pool.federated[0].workload_identity_pool_id}/*"
}
