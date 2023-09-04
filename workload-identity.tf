resource "google_service_account" "cloud_dns" {
  account_id   = "cloud-dns"
  project    = var.project_id
}

//change name 
resource "google_project_iam_member" "my-builder-storage-admin" {
#   service_account_id = google_service_account.external-dns.name
  project            = var.project_id
  role               = "roles/dns.admin"
  member            =  "serviceAccount:${google_service_account.cloud_dns.email}"
  }


resource "google_service_account_iam_binding" "external_dns_workload_identity" {
  service_account_id = google_service_account.cloud_dns.name
  role               = "roles/iam.workloadIdentityUser"
  members            = [
    "serviceAccount:${var.project_id}.svc.id.goog[external-dns/external-dns]",
    "serviceAccount:${var.project_id}.svc.id.goog[cert-manager/cert-manager]",
    "serviceAccount:${var.project_id}.svc.id.goog[wayfinder/wayfinder-admin]",
    "serviceAccount:${var.project_id}.svc.id.goog[ws-admin/default]",
  ]
}

