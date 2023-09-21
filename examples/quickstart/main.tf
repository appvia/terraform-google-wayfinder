terraform {
  required_version = ">= 1.5"

  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.9.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.23.0"
    }
    google = {
      source  = "hashicorp/google"
      version = ">= 4.82"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.14.0"
    }
  }
}

module "network" {
  source  = "terraform-google-modules/network/google"
  version = "~> 7.3"

  project_id = var.region

  network_name = "wayfinder-${var.environment}"

  subnets = [
    {
      subnet_name   = "compute"
      subnet_ip     = "10.10.0.0/19"
      subnet_region = var.region
    }

  ]

  secondary_ranges = {
    compute = [
      {
        range_name    = "pods"
        ip_cidr_range = "10.10.32.0/19"

      },
      {
        range_name    = "services"
        ip_cidr_range = "10.10.64.0/19"
      },
    ]
  }
}

module "wayfinder" {
  source = "/home/vaijab/work/appvia/git/terraform-gcp-wayfinder"

  gcp_project                    = var.gcp_project
  environment                    = var.environment
  gcp_region                     = var.region
  gcp_network_name               = module.network.network_name
  gcp_subnetwork_name            = module.network.subnets[join("/", [var.region, "compute"])].name
  pods_subnetwork_range_name     = "pods"
  services_subnetwork_range_name = "services"

  wayfinder_domain_name_ui  = var.wayfinder_domain_name_ui
  wayfinder_domain_name_api = var.wayfinder_domain_name_api

  clusterissuer_email   = var.clusterissuer_email
  wayfinder_licence_key = var.wayfinder_licence_key
  wayfinder_instance_id = var.wayfinder_instance_id
}
