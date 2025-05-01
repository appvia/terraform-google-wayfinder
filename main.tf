locals {
  name = format("wayfinder-%s", var.environment)

  labels = merge({
    provisioner = "terraform"
    environment = var.environment
  }, var.labels)

  service_account_suffix = substr(var.wayfinder_instance_id, -6, -1)
  wayfinder_admin_sa_id  = substr(replace(lower("wf-admin-${local.service_account_suffix}"), "-", ""), 0, 29)
}

resource "random_id" "random_suffix" {
  byte_length = 4
}
