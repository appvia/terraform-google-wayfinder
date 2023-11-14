resource "google_service_account" "peeringacceptor" {
  count = var.enable_peering_acceptor ? 1 : 0

  account_id   = "${local.resource_prefix}peeraccpt${local.resource_suffix}"
  display_name = "Peering Acceptor"
}

resource "google_project_iam_member" "peeringacceptor" {
  count = var.enable_peering_acceptor ? 1 : 0

  project = data.google_project.project.id
  role    = google_project_iam_custom_role.peeringacceptor[0].name
  member  = google_service_account.peeringacceptor[0].member
}

resource "google_service_account_iam_member" "peeringacceptor" {
  count = var.enable_peering_acceptor && (var.from_gcp) ? 1 : 0

  service_account_id = google_service_account.peeringacceptor[0].name
  role               = "roles/iam.serviceAccountTokenCreator"
  member             = data.google_service_account.wayfinder[0].member
}

resource "google_project_iam_custom_role" "peeringacceptor" {
  count       = var.enable_peering_acceptor ? 1 : 0
  role_id     = "${local.resource_prefix}peeraccpt${local.resource_suffix}"
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

resource "google_service_account_iam_member" "peeringacceptorfederated" {
  count = var.enable_peering_acceptor && (var.from_aws || var.from_azure) ? 1 : 0

  service_account_id = google_service_account.peeringacceptor[0].name
  role               = "roles/iam.serviceAccountTokenCreator"

  # we should possibly make this more specific (although our pool already limits to the correct IRSA role)
  member = "principalSet://iam.googleapis.com/projects/${data.google_project.project.number}/locations/global/workloadIdentityPools/${google_iam_workload_identity_pool.federated[0].workload_identity_pool_id}/*"
}
