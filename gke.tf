resource "google_service_account" "gke_service_account" {
  account_id   = local.name
  display_name = "Wayfinder GKE ${local.name} service account"
}

#trivy:ignore:AVD-GCP-0048
resource "google_container_cluster" "gke" {
  name = local.name

  initial_node_count       = 1
  location                 = var.gcp_region
  min_master_version       = var.gke_version
  network                  = var.gcp_network_name
  remove_default_node_pool = true
  resource_labels          = local.labels
  subnetwork               = var.gcp_subnetwork_name

  addons_config {
    network_policy_config {
      disabled = false
    }
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

  ip_allocation_policy {
    cluster_secondary_range_name  = var.pods_subnetwork_range_name
    services_secondary_range_name = var.services_subnetwork_range_name
  }

  logging_config {
    enable_components = ["SYSTEM_COMPONENTS", "WORKLOADS"]
  }

  maintenance_policy {
    daily_maintenance_window {
      start_time = "03:00"
    }
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

  monitoring_config {
    enable_components = ["SYSTEM_COMPONENTS"]
  }

  network_policy {
    enabled  = true
    provider = "CALICO"
  }

  #tfsec:ignore:google-gke-enable-private-cluster
  private_cluster_config {
    enable_private_endpoint = var.disable_internet_access
  }

  release_channel {
    channel = var.gke_release_channel
  }

  workload_identity_config {
    workload_pool = "${var.gcp_project}.svc.id.goog"
  }
}

resource "google_container_node_pool" "nodes" {
  name     = "wayfinder"
  location = var.gcp_region
  cluster  = google_container_cluster.gke.name

  autoscaling {
    total_min_node_count = var.gke_nodes_minimum_size
    total_max_node_count = 10
    location_policy      = "ANY"
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  #trivy:ignore:AVD-GCP-0048
  node_config {
    machine_type    = var.gke_nodes_machine_type
    metadata        = { disable-legacy-endpoints = true }
    oauth_scopes    = ["https://www.googleapis.com/auth/cloud-platform"]
    service_account = google_service_account.gke_service_account.email
    workload_metadata_config { mode = "GKE_METADATA" }
  }
}
