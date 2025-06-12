resource "google_service_account" "wayfinder" {
  account_id   = local.serviceaccount_id
  display_name = "Cluster Manager"
}

resource "google_service_account_iam_member" "wayfinder" {
  count = (var.from_gcp) ? 1 : 0

  service_account_id = google_service_account.wayfinder.name
  role               = "roles/iam.serviceAccountTokenCreator"
  member             = data.google_service_account.wayfinder[0].member
}

resource "google_service_account_iam_member" "wayfinderfederated" {
  count = (var.from_aws || var.from_azure) ? 1 : 0

  service_account_id = google_service_account.wayfinder.name
  role               = "roles/iam.serviceAccountTokenCreator"

  # we should possibly make this more specific (although our pool already limits to the correct IRSA role)
  member = "principalSet://iam.googleapis.com/projects/${data.google_project.project.number}/locations/global/workloadIdentityPools/${google_iam_workload_identity_pool.federated[0].workload_identity_pool_id}/*"
}