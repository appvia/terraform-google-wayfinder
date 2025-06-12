resource "google_project_iam_member" "clustermanager" {
  count = var.enable_cluster_manager_permissions ? 1 : 0

  project = data.google_project.project.id
  role    = google_project_iam_custom_role.clustermanager[0].name
  member  = google_service_account.wayfinder.member
}

# Add the Kubernetes Engine Admin predefined role
resource "google_project_iam_member" "clustermanager_k8s_admin" {
  count = var.enable_cluster_manager_permissions ? 1 : 0

  project = data.google_project.project.id
  role    = "roles/container.admin"
  member  = google_service_account.wayfinder.member
}

resource "google_project_iam_custom_role" "clustermanager" {
  count = var.enable_cluster_manager_permissions ? 1 : 0

  role_id     = local.clustermgr_role_id
  title       = "Cluster Manager"
  description = "Permissions for wayfinder to manage Clusters"

  permissions = [
    "compute.addresses.list",
    "compute.firewalls.delete",
    "compute.firewalls.list",
    "compute.forwardingRules.list",
    "compute.globalOperations.list",
    "compute.networks.create",
    "compute.networks.delete",
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
    "container.clusters.get",
    "container.clusters.getCredentials",
    "container.clusters.list",
    "container.clusters.update",
    "container.operations.get",
    "container.operations.list",
    "container.podSecurityPolicies.create",
    "container.secrets.create",
    "container.secrets.get",
    "container.serviceAccounts.create",
    "container.serviceAccounts.createToken",
    "container.serviceAccounts.get",
    "container.services.delete",
    "container.services.list",
    "iam.serviceAccounts.actAs",
    "iam.serviceAccounts.create",
    "iam.serviceAccounts.delete",
    "iam.serviceAccounts.get",
    "iam.serviceAccounts.getIamPolicy",
    "iam.serviceAccounts.list",
    "iam.serviceAccounts.setIamPolicy",
    "resourcemanager.projects.get",
    "resourcemanager.projects.getIamPolicy",
    "resourcemanager.projects.setIamPolicy",
  ]
}
