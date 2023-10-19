locals {
  suffix_instance_id = var.instance_id != "" ? "-${substr(var.instance_id, 0, 10)}" : ""
  suffix_custom      = var.suffix != "" ? "-${var.suffix}" : ""
  resource_suffix    = "${local.suffix_instance_id}${local.suffix_custom}"
}
