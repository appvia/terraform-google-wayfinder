resource "google_project_iam_custom_role" "wayfinder_cloudinfo" {
  count       = var.enable_wf_cloudaccess ? 1 : 0
  role_id     = "wayfinder.cloudInfo.${local.service_account_suffix}.${random_id.random_suffix.hex}"
  project     = var.gcp_project
  title       = "Wayfinder Cloud Info"
  description = "Retrieve pricing information for GCP cloud resources"
  permissions = [
    "compute.machineTypes.list",
    "compute.regions.list",
    "resourcemanager.projects.get",
  ]
}

resource "google_project_iam_member" "wayfinder_cloudinfo" {
  count   = var.enable_wf_cloudaccess ? 1 : 0
  project = var.gcp_project
  role    = google_project_iam_custom_role.wayfinder_cloudinfo[0].id
  member  = "serviceAccount:${google_service_account.wayfinder.email}"
}

resource "kubectl_manifest" "wayfinder_cloud_identity_main" {
  count      = var.enable_k8s_resources && var.enable_wf_cloudaccess ? 1 : 0
  depends_on = [helm_release.wayfinder]

  yaml_body = templatefile("${path.module}/manifests/wayfinder-cloud-identity.yml.tpl", {
    name                 = "cloudidentity-gcp"
    description          = "Cloud managed identity"
    implicit_identity_id = google_service_account.wayfinder.email
  })
}
