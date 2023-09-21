resource "google_service_account" "gke_service_account" {
  account_id   = local.name
  display_name = "Wayfinder GKE ${local.name} service account"
}

resource "google_container_cluster" "gke" {
  name                     = local.name
  location                 = var.gcp_region
  resource_labels          = local.labels
  initial_node_count       = 1
  remove_default_node_pool = true

  network    = var.gcp_network_name
  subnetwork = var.gcp_subnetwork_name

  ip_allocation_policy {
    cluster_secondary_range_name  = var.pods_subnetwork_range_name
    services_secondary_range_name = var.services_subnetwork_range_name
  }

  master_authorized_networks_config {
    gcp_public_cidrs_access_enabled = var.disable_internet_access ? false : true

    dynamic "cidr_blocks" {
      for_each = var.cluster_endpoint_public_access_cidrs
      content {
        cidr_block = cidr_blocks.value
      }
    }
  }

  private_cluster_config {
    enable_private_endpoint = var.disable_internet_access
  }

  workload_identity_config {
    workload_pool = "${var.gcp_project}.svc.id.goog"
  }

  cluster_autoscaling {
    enabled = true

    resource_limits {
      resource_type = "cpu"
      minimum       = 3
      maximum       = 10
    }
    resource_limits {
      resource_type = "memory"
      minimum       = 4
      maximum       = 16
    }
  }
}

resource "google_container_node_pool" "nodes" {
  name       = "wayfinder"
  location   = var.gcp_region
  cluster    = google_container_cluster.gke.name
  node_count = var.gke_nodes_minimum_size

  node_config {
    workload_metadata_config {
      mode = "GKE_METADATA"
    }

    machine_type = var.gke_nodes_machine_type

    service_account = google_service_account.gke_service_account.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}
