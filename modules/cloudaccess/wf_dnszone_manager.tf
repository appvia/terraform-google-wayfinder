resource "google_project_iam_member" "dnszonemanager" {
  count = var.enable_dns_zone_manager_permissions ? 1 : 0

  project = data.google_project.project.id
  role    = "roles/dns.admin"
  member  = google_service_account.wayfinder.member
}
