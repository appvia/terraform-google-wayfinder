resource "google_service_account" "cert_manager" {
  account_id   = "wf-cert-manager-${local.service_account_suffix}"
  display_name = "Wayfinder cert-manager"
}

resource "google_service_account_iam_binding" "cert_manager" {
  service_account_id = google_service_account.cert_manager.name
  role               = "roles/iam.workloadIdentityUser"
  members = [
    "serviceAccount:${var.gcp_project}.svc.id.goog[cert-manager/cert-manager]"
  ]
}

resource "google_project_iam_member" "cert_manager" {
  project = var.gcp_project
  role    = "roles/dns.admin"
  member  = "serviceAccount:${google_service_account.cert_manager.email}"
}

resource "helm_release" "certmanager" {
  count = var.enable_k8s_resources ? 1 : 0

  depends_on = [
    google_container_cluster.gke,
  ]

  namespace        = "cert-manager"
  create_namespace = true

  name        = "cert-manager"
  repository  = "https://charts.jetstack.io"
  chart       = "cert-manager"
  version     = "v1.14.5"
  max_history = 5

  set {
    name  = "installCRDs"
    value = "true"
  }

  set {
    name  = "serviceAccount.annotations.iam\\.gke\\.io/gcp-service-account"
    value = google_service_account.cert_manager.email
  }

  set {
    name  = "ingressShim.defaultIssuerName"
    value = "letsencrypt-prod"
  }

  set {
    name  = "ingressShim.defaultIssuerKind"
    value = "ClusterIssuer"
  }

  set {
    name  = "ingressShim.defaultIssuerGroup"
    value = "cert-manager.io"
  }
}

resource "kubectl_manifest" "certmanager_clusterissuer" {
  count = var.enable_k8s_resources ? 1 : 0

  depends_on = [
    google_container_cluster.gke,
    helm_release.certmanager,
  ]

  yaml_body = templatefile("${path.module}/manifests/certmanager-clusterissuer.yml.tpl", {
    email   = var.clusterissuer_email
    project = var.gcp_project
  })
}
