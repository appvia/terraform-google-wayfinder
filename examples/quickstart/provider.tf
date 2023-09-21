provider "google" {
  project = var.gcp_project
  region  = var.region
}

provider "helm" {
  kubernetes {
    cluster_ca_certificate = base64decode(module.wayfinder.cluster_ca_certificate)
    host                   = "https://${module.wayfinder.cluster_endpoint}"

    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "gke-gcloud-auth-plugin"
    }
  }
}

provider "kubectl" {
  cluster_ca_certificate = base64decode(module.wayfinder.cluster_ca_certificate)
  host                   = "https://${module.wayfinder.cluster_endpoint}"
  load_config_file       = false

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "gke-gcloud-auth-plugin"
  }
}

provider "kubernetes" {
  cluster_ca_certificate = base64decode(module.wayfinder.cluster_ca_certificate)
  host                   = "https://${module.wayfinder.cluster_endpoint}"

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "gke-gcloud-auth-plugin"
  }
}
