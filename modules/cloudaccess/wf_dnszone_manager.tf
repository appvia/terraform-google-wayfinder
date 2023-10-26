resource "google_service_account" "dnszonemanager" {
  count = var.enable_dns_zone_manager ? 1 : 0

  account_id   = "${local.resource_prefix}dnszonemgr${local.resource_suffix}"
  display_name = "DNS Zone Manager"
}

resource "google_project_iam_member" "dnszonemanager" {
  count = var.enable_dns_zone_manager ? 1 : 0

  project = data.google_project.project.id
  role    = google_project_iam_custom_role.dnszonemanager[0].name
  member  = google_service_account.dnszonemanager[0].member
}

resource "google_project_iam_member" "dnszonemanageradmin" {
  count = var.enable_dns_zone_manager ? 1 : 0

  project = data.google_project.project.id
  role    = "roles/dns.admin"
  member  = google_service_account.dnszonemanager[0].member
}

resource "google_project_iam_custom_role" "dnszonemanager" {
  count       = var.enable_dns_zone_manager ? 1 : 0
  role_id     = "${local.resource_prefix}dnszonemgr${local.resource_suffix}"
  title       = "DNS Zone Manager"
  description = "Permissions for wayfinder to manage DNS Zones"
  permissions = [
    "dns.resourceRecordSets.list",
    "dns.changes.create",
    "dns.managedZones.get",
    "dns.managedZones.create",
    "dns.managedZones.delete",
  ]
}

resource "google_service_account_iam_member" "dnszonemanager" {
  count = var.enable_dns_zone_manager && (var.from_gcp) ? 1 : 0

  service_account_id = google_service_account.dnszonemanager[0].name
  role               = "roles/iam.serviceAccountTokenCreator"
  member             = data.google_service_account.wayfinder[0].member
}

resource "google_service_account_iam_member" "dnszonemanagerfederated" {
  count = var.enable_dns_zone_manager && (var.from_aws || var.from_azure) ? 1 : 0

  service_account_id = google_service_account.dnszonemanager[0].name
  role               = "roles/iam.serviceAccountTokenCreator"

  # we should possibly make this more specific (although our pool already limits to the correct IRSA role)
  member = "principalSet://iam.googleapis.com/projects/${data.google_project.project.number}/locations/global/workloadIdentityPools/${google_iam_workload_identity_pool.federated[0].workload_identity_pool_id}/*"
}