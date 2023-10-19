resource "google_service_account" "cloudidentity" {
  account_id   = "wf-cloudidentity${local.resource_suffix}"
  display_name = "Cloud Identity"
}

resource "google_service_account_key" "cloudidentity" {
  service_account_id = google_service_account.cloudidentity.name
}