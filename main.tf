locals {
  name = format("wayfinder-%s", var.environment)

  labels = merge({
    provisioner = "terraform"
    environment = var.environment
  }, var.labels)
}
