resource "google_project_iam_member" "custom_role" {
  for_each = toset(var.custom_role_ids)

  project = data.google_project.project.id
  role    = each.key
  member  = google_service_account.wayfinder.member
}

resource "google_project_iam_member" "custom_permissions" {
  count = length(var.custom_permissions) > 0 ? 1 : 0

  project = data.google_project.project.id
  role    = google_project_iam_custom_role.custom_permissions[0].name
  member  = google_service_account.wayfinder.member
}

resource "google_project_iam_custom_role" "custom_permissions" {
  count = length(var.custom_permissions) > 0 ? 1 : 0

  role_id     = local.custom_role_id
  title       = "Wayfinder custom permissions"
  description = "Custom permissions for use in wayfinder"
  permissions = var.custom_permissions
}
