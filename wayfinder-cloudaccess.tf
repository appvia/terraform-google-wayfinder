module "wayfinder_cloudaccess" {
  count  = var.enable_wf_cloudaccess ? 1 : 0
  source = "./modules/cloudaccess"

  resource_suffix                        = var.cloudaccess_resource_suffix
  wayfinder_identity_gcp_service_account = google_service_account.wayfinder.email
  enable_dns_zone_manager                = var.enable_wf_dnszonemanager
  enable_cloud_info                      = var.enable_wf_costestimates
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

resource "kubectl_manifest" "wayfinder_gcp_cloudinfo_cloudaccessconfig" {
  count = var.enable_k8s_resources && var.enable_wf_cloudaccess && var.enable_wf_costestimates ? 1 : 0

  depends_on = [
    helm_release.wayfinder,
    kubectl_manifest.wayfinder_cloud_identity_main,
  ]

  yaml_body = templatefile("${path.module}/manifests/wayfinder-gcp-cloudaccessconfig.yml.tpl", {
    project_id          = var.gcp_project
    description         = "Used for cost data retrieval in order to provide infrastructure cost estimates."
    identity            = "cloudidentity-gcp"
    name                = "gcp-cloudinfo"
    permission          = "CloudInfo"
    gcp_service_account = module.wayfinder_cloudaccess[0].cloud_info_service_account
    type                = "CostsEstimates"
  })
}

resource "kubectl_manifest" "wayfinder_gcp_dnszonemanager_cloudaccessconfig" {
  count = var.enable_k8s_resources && var.enable_wf_cloudaccess && var.enable_wf_dnszonemanager ? 1 : 0

  depends_on = [
    helm_release.wayfinder,
    kubectl_manifest.wayfinder_cloud_identity_main,
  ]

  yaml_body = templatefile("${path.module}/manifests/wayfinder-gcp-cloudaccessconfig.yml.tpl", {
    project_id          = var.gcp_project
    description         = "Used for managing a top-level domain, so that Wayfinder can create sub domains within it that are delegated to workspace clusters."
    identity            = "cloudidentity-gcp"
    name                = "gcp-dnsmanagement"
    permission          = "DNSZoneManager"
    gcp_service_account = module.wayfinder_cloudaccess[0].dns_zone_manager_service_account
    type                = "DNSZoneManagement"
  })
}
