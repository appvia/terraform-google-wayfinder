module "network" {
  source  = "terraform-google-modules/network/google"
  version = "7.3.0"

  network_name = "wayfinder-${var.environment}"
  project_id   = var.gcp_project

  subnets = [
    {
      subnet_name           = "compute"
      subnet_ip             = "10.10.0.0/19"
      subnet_region         = var.gcp_region
      subnet_private_access = true
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
