resource "google_project_iam_member" "networkmanager" {
  count = var.enable_network_manager_permissions ? 1 : 0

  project = data.google_project.project.id
  role    = google_project_iam_custom_role.networkmanager[0].name
  member  = google_service_account.wayfinder.member
}

resource "google_project_iam_custom_role" "networkmanager" {
  count = var.enable_network_manager_permissions ? 1 : 0

  role_id     = local.networkmgr_role_id
  title       = "Network Manager"
  description = "Permissions for wayfinder to manage Networks"

  permissions = [
    "compute.addresses.list",
    "compute.firewalls.delete",
    "compute.firewalls.list",
    "compute.forwardingRules.list",
    "compute.globalOperations.list",
    "compute.networks.create",
    "compute.networks.delete",
    "compute.networks.get",
    "compute.networks.updatePolicy",
    "compute.regionOperations.list",
    "compute.routers.list",
    "compute.subnetworks.create",
    "compute.subnetworks.delete",
    "compute.subnetworks.list",
    "container.clusterRoleBindings.create",
    "container.clusterRoleBindings.get",
    "container.clusterRoles.bind",
    "container.clusterRoles.create",
    "container.clusters.create",
    "container.clusters.delete",
    "container.clusters.getCredentials",
    "container.clusters.list",
    "container.operations.get",
    "container.operations.list",
    "container.podSecurityPolicies.create",
    "container.secrets.get",
    "container.serviceAccounts.create",
    "container.serviceAccounts.get",
    "iam.serviceAccounts.actAs",
    "iam.serviceAccounts.get",
    "iam.serviceAccounts.list",
    "resourcemanager.projects.get",
  ]
}
