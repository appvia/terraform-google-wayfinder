resource "google_project_iam_member" "peeringacceptor" {
  count = var.enable_peering_acceptor_permissions ? 1 : 0

  project = data.google_project.project.id
  role    = google_project_iam_custom_role.peeringacceptor[0].name
  member  = google_service_account.wayfinder.member
}

resource "google_project_iam_custom_role" "peeringacceptor" {
  count       = var.enable_peering_acceptor_permissions ? 1 : 0
  role_id     = local.peeraccpt_role_id
  title       = "Peering Acceptor"
  description = "Permissions for wayfinder to accept peering connection"
  permissions = [
    "compute.networks.get",
    "compute.networks.removePeering",
    "compute.globalOperations.list",
    "compute.networks.addPeering",
    "resourcemanager.projects.get",
  ]
}
