resource "google_project_iam_member" "cloudinfo" {
  count = var.enable_cloud_info_permissions ? 1 : 0

  project = data.google_project.project.id
  role    = google_project_iam_custom_role.cloudinfo[0].name
  member  = google_service_account.wayfinder.member
}

resource "google_project_iam_custom_role" "cloudinfo" {
  count       = var.enable_cloud_info_permissions ? 1 : 0
  role_id     = local.cloudinfo_role_id
  title       = "Cloud Info"
  description = "Permissions for wayfinder to retrieve pricing and instance type metadata"
  permissions = [
    "compute.machineTypes.list",
    "compute.regions.list",
    "resourcemanager.projects.get",
  ]
}
