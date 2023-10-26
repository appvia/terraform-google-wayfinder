resource "google_project_iam_member" "wayfinder_workload_identity_user" {
  count = (var.from_gcp) ? 1 : 0

  project = data.google_project.project.id
  role    = "roles/iam.workloadIdentityUser"
  member  = "serviceAccount:${var.wayfinder_identity_gcp_service_account}"
}
