resource "helm_release" "cert_manager" {
  count = var.enable_k8s_resources ? 1 : 0

  depends_on = [
    module.gke,
  ]

  namespace        = "cert-manager"
  create_namespace = true

  name        = "cert-manager"
  repository  = "https://charts.jetstack.io"
  chart       = "cert-manager"
  version     = "v1.11.0"
  max_history = 5

  values = [templatefile("${path.module}/manifests/cert-manager-values.yml.tpl", {})]
}

resource "kubectl_manifest" "cert_manager_clusterissuer" {
  count = var.enable_k8s_resources ? 1 : 0

  depends_on = [
    module.gke,
    helm_release.cert_manager,
  ]

  yaml_body = templatefile("${path.module}/manifests/cert-manager-clusterissuer.yml.tpl", { 
    email                   = var.clusterissuer_email
    project_id              = var.project_id
   

  
  })
}

