resource "google_service_account" "clustermanager" {
  count = var.enable_cluster_manager ? 1 : 0

  account_id   = "${local.resource_prefix}clustermgr${local.resource_suffix}"
  display_name = "Cluster Manager"
}

resource "google_project_iam_member" "clustermanager" {
  count = var.enable_cluster_manager ? 1 : 0

  project = data.google_project.project.id
  role    = google_project_iam_custom_role.clustermanager[0].name
  member  = google_service_account.clustermanager[0].member
}

resource "google_project_iam_custom_role" "clustermanager" {
  count       = var.enable_cluster_manager ? 1 : 0

  role_id     = "${local.resource_prefix}clustermgr${local.resource_suffix}"
  title       = "Cluster Manager"
  description = "Permissions for wayfinder to manage Clusters"

  permissions = [
    "compute.firewalls.list",
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


resource "google_service_account_iam_member" "clustermanager" {
  count = var.enable_cluster_manager && (var.from_gcp) ? 1 : 0

  service_account_id = google_service_account.clustermanager[0].name
  role               = "roles/iam.serviceAccountTokenCreator"
  member             = data.google_service_account.wayfinder[0].member
}

resource "google_service_account_iam_member" "clustermanagerfederated" {
  count = var.enable_cluster_manager && (var.from_aws || var.from_azure) ? 1 : 0

  service_account_id = google_service_account.clustermanager[0].name
  role               = "roles/iam.serviceAccountTokenCreator"

  # we should possibly make this more specific (although our pool already limits to the correct IRSA role)
  member = "principalSet://iam.googleapis.com/projects/${data.google_project.project.number}/locations/global/workloadIdentityPools/${google_iam_workload_identity_pool.federated[0].workload_identity_pool_id}/*"
}
