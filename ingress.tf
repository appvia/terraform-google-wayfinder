resource "helm_release" "ingress" {
  count = var.enable_k8s_resources ? 1 : 0

  depends_on = [
    google_container_cluster.gke,
  ]

  namespace        = "ingress-nginx"
  create_namespace = true

  name        = "ingress-nginx"
  repository  = "https://kubernetes.github.io/ingress-nginx"
  chart       = "ingress-nginx"
  version     = "4.11.2"
  max_history = 5

  set {
    name  = "defaultBackend.service.type"
    value = "LoadBalancer"
  }

  set {
    name  = "controller.service.annotations.networking\\.gke\\.io/load-balancer-type"
    value = var.disable_internet_access ? "Internal" : "External"
  }
}
