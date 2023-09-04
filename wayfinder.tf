# resource "kubectl_manifest" "wayfinder_idp" {
#   count = (var.enable_k8s_resources && var.wayfinder_idp_details["type"] == "generic") ? 1 : 0

#   depends_on = [
#     kubectl_manifest.wayfinder_namespace,
#     module.aks,
#   ]

#   sensitive_fields = ["stringData"]

#   yaml_body = templatefile("${path.module}/manifests/wayfinder-idp.yml.tpl", {
#     claims        = "preferred_username,email,name,username"
#     client_id     = var.wayfinder_idp_details["clientId"]
#     client_scopes = "email,profile,offline_access"
#     client_secret = var.wayfinder_idp_details["clientSecret"]
#     name          = "wayfinder-idp-live"
#     namespace     = "wayfinder"
#     server_url    = var.wayfinder_idp_details["serverUrl"]
#   })
# }

# resource "kubectl_manifest" "wayfinder_idp_aad" {
#   count = (var.enable_k8s_resources && var.wayfinder_idp_details["type"] == "aad") ? 1 : 0

#   depends_on = [
#     kubectl_manifest.wayfinder_namespace,
#     module.aks,
#   ]

#   sensitive_fields = ["stringData"]

#   yaml_body = templatefile("${path.module}/manifests/wayfinder-idp-aad.yml.tpl", {
#     claims        = "preferred_username,email,name,username"
#     client_id     = var.wayfinder_idp_details["clientId"]
#     client_scopes = "email,profile,offline_access"
#     client_secret = var.wayfinder_idp_details["clientSecret"]
#     name          = "wayfinder-idp-live"
#     namespace     = "wayfinder"
#     provider      = "azure"
#     tenant_id     = var.wayfinder_idp_details["azureTenantId"]
#   })
# }

resource "helm_release" "wayfinder" {
  count = var.enable_k8s_resources ? 1 : 0

  depends_on = [
    helm_release.cert_manager,
    helm_release.external_dns,
    helm_release.ingress,
    kubectl_manifest.cert_manager_clusterissuer,
    module.gke,
  ]

  name = "wayfinder"

  chart            = "https://storage.googleapis.com/${var.wayfinder_release_channel}/${var.wayfinder_version}/wayfinder-helm-chart.tgz"
  create_namespace = false
  max_history      = 5
  namespace        = "wayfinder"
  timeout          = 600

  values = [
    templatefile("${path.module}/manifests/wayfinder-values.yml.tpl", {
      api_hostname                  = var.wayfinder_domain_name_api
      storage_class                 = "standard"
      ui_hostname                   = var.wayfinder_domain_name_ui
      project_id                    = "kore-demo"
    #   wayfinder_client_id           = azurerm_user_assigned_identity.wayfinder_main.client_id
      wayfinder_cluster_id          = module.gke.name
      wayfinder_instance_identifier = var.wayfinder_instance_id
    #   wayfinder_iam_identity        =  
    
    })
  ]

  set_sensitive {
    name  = "licenseKey"
    value = var.wayfinder_license_key
  }
}