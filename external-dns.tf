resource "random_id" "external_dns_sa_suffix" {
  byte_length = 4
}

resource "google_service_account" "external_dns" {
  account_id   = "wf-external-dns-${random_id.external_dns_sa_suffix.hex}"
  display_name = "Wayfinder external-dns"
}

resource "google_service_account_iam_binding" "external_dns" {
  service_account_id = google_service_account.external_dns.name
  role               = "roles/iam.workloadIdentityUser"
  members = [
    "serviceAccount:${var.gcp_project}.svc.id.goog[external-dns/external-dns]"
  ]
}

resource "google_project_iam_member" "external_dns" {
  project = var.gcp_project
  role    = "roles/dns.admin"
  member  = "serviceAccount:${google_service_account.external_dns.email}"
}

resource "helm_release" "external-dns" {
  count = var.enable_k8s_resources ? 1 : 0

  depends_on = [
    google_container_cluster.gke,
  ]

  namespace        = "external-dns"
  create_namespace = true

  name        = "external-dns"
  repository  = "https://charts.bitnami.com/bitnami"
  chart       = "external-dns"
  version     = "6.18.0"
  max_history = 5

  set {
    name  = "serviceAccount.annotations.iam\\.gke\\.io/gcp-service-account"
    value = google_service_account.external_dns.email
  }

  set {
    name  = "provider"
    value = "google"
  }
}
