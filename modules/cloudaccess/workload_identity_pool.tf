resource "google_iam_workload_identity_pool" "federated" {
  count = (var.from_aws || var.from_azure) ? 1 : 0

  workload_identity_pool_id = "${local.resource_prefix}pool${local.resource_suffix}"
  display_name              = "Wayfinder CloudIdentity trust"
  description               = "Provides access to GCP from Wayfinder installed on AWS or Azure"
  disabled                  = false
}

resource "google_iam_workload_identity_pool_provider" "aws_federated" {
  count = var.from_aws ? 1 : 0

  workload_identity_pool_id          = google_iam_workload_identity_pool.federated[0].workload_identity_pool_id
  workload_identity_pool_provider_id = "${local.resource_prefix}aws${local.resource_suffix}"
  display_name                       = "Wayfinder AWS role trust"
  description                        = "AWS identity pool provider for Wayfinder IRSA role"
  disabled                           = false
  attribute_condition                = "attribute.aws_role==\"arn:aws:sts::${local.aws_account_id}:assumed-role/${local.aws_role_name}\""
  attribute_mapping = {
    "attribute.aws_role"    = "assertion.arn.contains('assumed-role') ? assertion.arn.extract('{account_arn}assumed-role/') + 'assumed-role/' + assertion.arn.extract('assumed-role/{role_name}/') : assertion.arn"
    "google.subject"        = "assertion.arn"
    "attribute.aws_account" = "assertion.account"
  }
  aws {
    account_id = local.aws_account_id
  }
}

resource "google_iam_workload_identity_pool_provider" "azure_federated" {
  count = var.from_azure ? 1 : 0

  workload_identity_pool_id          = google_iam_workload_identity_pool.federated[0].workload_identity_pool_id
  workload_identity_pool_provider_id = "${local.resource_prefix}azure${local.resource_suffix}"
  display_name                       = "Wayfinder Azure Identity trust"
  description                        = "Azure identity pool provider for Wayfinder Managed Identity Client ID"
  disabled                           = false
  attribute_condition                = "assertion.aud==\"${var.wayfinder_identity_azure_client_id}\""
  attribute_mapping = {
    "google.subject" = "assertion.sub"
  }
  oidc {
    issuer_uri        = "https://sts.windows.net/${var.wayfinder_identity_azure_tenant_id}/"
    allowed_audiences = [var.wayfinder_identity_azure_client_id]
  }

  lifecycle {
    precondition {
      condition     = var.wayfinder_identity_azure_tenant_id != "" || var.wayfinder_identity_azure_client_id != ""
      error_message = "Must specify wayfinder_identity_azure_tenant_id and wayfinder_identity_azure_client_id to enable cross-cloud trust from Azure to AGCPWS"
    }
  }
}
