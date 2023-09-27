resource "google_service_account" "wayfinder" {
  account_id   = "wf-admin-${local.service_account_suffix}"
  display_name = "Wayfinder admin service account"
}

resource "google_service_account_iam_binding" "wayfinder_workload_identity_user" {
  service_account_id = google_service_account.wayfinder.name
  role               = "roles/iam.workloadIdentityUser"
  members = [
    "serviceAccount:${var.gcp_project}.svc.id.goog[wayfinder/wayfinder-admin]"
  ]
}

resource "google_project_iam_custom_role" "wayfinder_cloudinfo" {
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
  project = var.gcp_project
  role    = google_project_iam_custom_role.wayfinder_cloudinfo.id
  member  = "serviceAccount:${google_service_account.wayfinder.email}"
}

resource "kubectl_manifest" "wayfinder_cloud_identity_main" {
  count      = var.enable_k8s_resources ? 1 : 0
  depends_on = [helm_release.wayfinder]

  yaml_body = templatefile("${path.module}/manifests/wayfinder-cloud-identity.yml.tpl", {
    name                 = "cloudidentity-gcp"
    description          = "Cloud managed identity"
    implicit_identity_id = google_service_account.wayfinder.email
  })
}

resource "kubectl_manifest" "storageclass" {
  count = var.enable_k8s_resources ? 1 : 0

  depends_on = [
    google_container_cluster.gke,
  ]

  yaml_body = templatefile("${path.module}/manifests/storageclass.yml.tpl", {})
}

resource "kubectl_manifest" "storageclass_encrypted" {
  count = var.enable_k8s_resources ? 1 : 0

  depends_on = [
    google_container_cluster.gke,
  ]

  yaml_body = templatefile("${path.module}/manifests/storageclass-encrypted.yml.tpl", {})
}


resource "kubectl_manifest" "wayfinder_namespace" {
  count = var.enable_k8s_resources ? 1 : 0

  depends_on = [
    google_container_cluster.gke,
  ]

  yaml_body = templatefile("${path.module}/manifests/wayfinder-namespace.yml.tpl", {
    namespace = "wayfinder"
  })
}

resource "kubectl_manifest" "wayfinder_idp" {
  count = (var.enable_k8s_resources && var.wayfinder_idp_details["type"] == "generic") ? 1 : 0

  depends_on = [
    kubectl_manifest.wayfinder_namespace,
    google_container_cluster.gke,
  ]

  sensitive_fields = ["stringData"]

  yaml_body = templatefile("${path.module}/manifests/wayfinder-idp.yml.tpl", {
    claims        = "preferred_username,email,name,username"
    client_id     = var.wayfinder_idp_details["clientId"]
    client_scopes = "email,profile,offline_access"
    client_secret = var.wayfinder_idp_details["clientSecret"]
    name          = "wayfinder-idp-live"
    namespace     = "wayfinder"
    server_url    = var.wayfinder_idp_details["serverUrl"]
  })
}

resource "kubectl_manifest" "wayfinder_idp_aad" {
  count = (var.enable_k8s_resources && var.wayfinder_idp_details["type"] == "aad") ? 1 : 0

  depends_on = [
    kubectl_manifest.wayfinder_namespace,
    google_container_cluster.gke
  ]

  sensitive_fields = ["stringData"]

  yaml_body = templatefile("${path.module}/manifests/wayfinder-idp-aad.yml.tpl", {
    claims        = "preferred_username,email,name,username"
    client_id     = var.wayfinder_idp_details["clientId"]
    client_scopes = "email,profile,offline_access"
    client_secret = var.wayfinder_idp_details["clientSecret"]
    name          = "wayfinder-idp-live"
    namespace     = "wayfinder"
    provider      = "azure"
    tenant_id     = var.wayfinder_idp_details["azureTenantId"]
  })
}

resource "random_password" "wayfinder_localadmin" {
  count   = var.create_localadmin_user ? 1 : 0
  length  = 20
  special = false
}

resource "helm_release" "wayfinder" {
  count = var.enable_k8s_resources ? 1 : 0

  depends_on = [
    google_container_cluster.gke,
    helm_release.certmanager,
    helm_release.external-dns,
    helm_release.ingress,
    kubectl_manifest.certmanager_clusterissuer,
    kubectl_manifest.storageclass_encrypted,
    kubectl_manifest.storageclass,
    kubectl_manifest.wayfinder_idp_aad,
    kubectl_manifest.wayfinder_idp,
    kubectl_manifest.wayfinder_namespace,
  ]

  name = "wayfinder"

  chart            = "https://storage.googleapis.com/${var.wayfinder_release_channel}/${var.wayfinder_version}/wayfinder-helm-chart.tgz"
  create_namespace = false
  max_history      = 5
  namespace        = "wayfinder"
  wait             = true
  wait_for_jobs    = true

  values = [
    templatefile("${path.module}/manifests/wayfinder-values.yml.tpl", {
      api_hostname                  = var.wayfinder_domain_name_api
      disable_local_login           = var.wayfinder_idp_details["type"] == "none" ? false : var.disable_local_login
      enable_localadmin_user        = var.create_localadmin_user
      storage_class                 = "standard-rwo-encrypted"
      ui_hostname                   = var.wayfinder_domain_name_ui
      wayfinder_iam_identity        = google_service_account.wayfinder.email
      wayfinder_instance_identifier = var.wayfinder_instance_id
    })
  ]

  set_sensitive {
    name  = "licenseKey"
    value = var.wayfinder_licence_key
  }

  set_sensitive {
    name  = "localAdminPassword"
    value = var.create_localadmin_user ? random_password.wayfinder_localadmin[0].result : ""
  }
}
