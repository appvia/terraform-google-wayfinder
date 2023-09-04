resource "kubectl_manifest" "external_dns_namespace" {
  count = var.enable_k8s_resources ? 1 : 0

  depends_on = [
    module.gke,
  ]

  yaml_body = templatefile("${path.module}/manifests/namespace.yml.tpl", {
    namespace = "external-dns"
  })
}


resource "helm_release" "external_dns" {
  count = var.enable_k8s_resources ? 1 : 0

  depends_on = [
    
    module.gke,
  ]

  namespace        = "external-dns"
  create_namespace = false

  name        = "external-dns"
  repository  = "https://charts.bitnami.com/bitnami"
  chart       = "external-dns"
  version     = "6.18.0"
  max_history = 5

  values = [
    templatefile("${path.module}/manifests/external-dns-values.yml.tpl", {
       project_id              = var.project_id
      
    })
  ]
}