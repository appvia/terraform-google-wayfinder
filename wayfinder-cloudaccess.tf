resource "kubectl_manifest" "wayfinder_namespace" {
  count = var.enable_k8s_resources ? 1 : 0

  depends_on = [
    module.gke,
  ]

  yaml_body = templatefile("${path.module}/manifests/namespace.yml.tpl", {
    namespace = "wayfinder"
  })
}

# resource "kubectl_manifest" "wayfinder_gke_admin_cloudaccessconfig" {
#   count = var.enable_k8s_resources ? 1 : 0

#   depends_on = [
#     helm_release.wayfinder,
#   ]

#   yaml_body = templatefile("${path.module}/manifests/wayfinder-gcp-admin-cloudaccessconfig.yml.tpl", {
#     region                    = data.google_client_config.current.region
#     account_id                = data.google_client_config.current.project_id
#     dns_zone_manager_role_arn = module.iam_assumable_role_dns_zone_manager.iam_role_arn
#     cloud_info_role_arn       = module.iam_assumable_role_cloud_info.iam_role_arn
#     identifier                = local.wayfinder_instance_id
#   })
# }