resource "kubectl_manifest" "wayfinder_cloud_identity_main" {
  count      = var.enable_k8s_resources ? 1 : 0
  depends_on = [helm_release.wayfinder]

  yaml_body = templatefile("${path.module}/manifests/wayfinder-cloud-identity.yml.tpl", {
    name                 = "cloudidentity-gcp"
    description          = "Cloud managed identity"
    # implicit_identity_id = azurerm_user_assigned_identity.wayfinder_main.client_id
  })
}