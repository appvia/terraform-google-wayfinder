<!-- BEGIN_TF_DOCS -->
# Terraform Module: Cloud Access for Wayfinder on GCP

This Terraform Module can be used to provision Service Accounts that Wayfinder uses, for creating resources within a Google Project.

**Notes:**
* You must set `var.wayfinder_identity_gcp_service_account` to the email address of the GCP service account that Wayfinder uses.
* `var.resource_suffix` is an optional suffix to use on created objects. We recommend using workspace key + stage if you wish to have multiple workspaces sharing the same AWS account, allowing independent roles to be provisioned for each.

## Deployment

Please see the [examples](./examples) directory to see how to deploy this module.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enable_cloud_info"></a> [enable\_cloud\_info](#input\_enable\_cloud\_info) | Whether to create the Cloud Info service account | `bool` | `false` | no |
| <a name="input_enable_cluster_manager"></a> [enable\_cluster\_manager](#input\_enable\_cluster\_manager) | Whether to create the Cluster Manager service account | `bool` | `false` | no |
| <a name="input_enable_dns_zone_manager"></a> [enable\_dns\_zone\_manager](#input\_enable\_dns\_zone\_manager) | Whether to create the DNS Zone Manager service account | `bool` | `false` | no |
| <a name="input_enable_network_manager"></a> [enable\_network\_manager](#input\_enable\_network\_manager) | Whether to create the Network Manager service account | `bool` | `false` | no |
| <a name="input_enable_peering_acceptor"></a> [enable\_peering\_acceptor](#input\_enable\_peering\_acceptor) | Whether to create the Peering Acceptor service account | `bool` | `false` | no |
| <a name="input_from_aws"></a> [from\_aws](#input\_from\_aws) | Whether Wayfinder is running on AWS. | `bool` | `false` | no |
| <a name="input_from_azure"></a> [from\_azure](#input\_from\_azure) | Whether Wayfinder is running on Azure. | `bool` | `false` | no |
| <a name="input_from_gcp"></a> [from\_gcp](#input\_from\_gcp) | Whether Wayfinder is running on GCP. | `bool` | `true` | no |
| <a name="input_resource_suffix"></a> [resource\_suffix](#input\_resource\_suffix) | Suffix to apply to all generated resources. We recommend using workspace key + stage. | `string` | `""` | no |
| <a name="input_wayfinder_identity_aws_role_arn"></a> [wayfinder\_identity\_aws\_role\_arn](#input\_wayfinder\_identity\_aws\_role\_arn) | ARN of Wayfinder's identity to give access to. Populate when Wayfinder is running on AWS with IRSA. | `string` | `""` | no |
| <a name="input_wayfinder_identity_azure_client_id"></a> [wayfinder\_identity\_azure\_client\_id](#input\_wayfinder\_identity\_azure\_client\_id) | Client ID of Wayfinder's Azure AD managed identity to give access to. Populate when Wayfinder is running on Azure with AzureAD Workload Identity. | `string` | `""` | no |
| <a name="input_wayfinder_identity_azure_tenant_id"></a> [wayfinder\_identity\_azure\_tenant\_id](#input\_wayfinder\_identity\_azure\_tenant\_id) | Tenant ID of Wayfinder's Azure AD managed identity to give access to. Populate when Wayfinder is running on Azure with AzureAD Workload Identity. | `string` | `""` | no |
| <a name="input_wayfinder_identity_gcp_service_account"></a> [wayfinder\_identity\_gcp\_service\_account](#input\_wayfinder\_identity\_gcp\_service\_account) | Email address of Wayfinder's GCP service account to give access to. Populate when Wayfinder is running on GCP with Workload Identity. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloud_info_service_account"></a> [cloud\_info\_service\_account](#output\_cloud\_info\_service\_account) | Email of Cloud Info service account to use as spec.permissions[].gcpServiceAccount on the CloudInfo permission of your cloud access config |
| <a name="output_cluster_manager_service_account"></a> [cluster\_manager\_service\_account](#output\_cluster\_manager\_service\_account) | Email of Cluster Manager service account to use as spec.permissions[].gcpServiceAccount on the ClusterManager permission of your cloud access config |
| <a name="output_dns_zone_manager_service_account"></a> [dns\_zone\_manager\_service\_account](#output\_dns\_zone\_manager\_service\_account) | Email of DNS Zone Manager service account to use as spec.permissions[].gcpServiceAccount on the DNSZoneManager permission of your cloud access config |
| <a name="output_gcp_project"></a> [gcp\_project](#output\_gcp\_project) | Project Name of the GCP project to use as spec.gcp.project of your cloud access config |
| <a name="output_gcp_projectnumber"></a> [gcp\_projectnumber](#output\_gcp\_projectnumber) | Project Number of the GCP project to use as spec.gcp.projectNumber of your cloud access config when enabling cross-cloud access to GCP from AWS or Azure |
| <a name="output_gcp_workload_identity_pool_id"></a> [gcp\_workload\_identity\_pool\_id](#output\_gcp\_workload\_identity\_pool\_id) | ID of GCP Workload Identity Pool to use as spec.gcp.workloadIdentityPoolID of your cloud access config when enabling cross-cloud access to GCP from AWS or Azure |
| <a name="output_gcp_workload_identity_provider_id_aws"></a> [gcp\_workload\_identity\_provider\_id\_aws](#output\_gcp\_workload\_identity\_provider\_id\_aws) | ID of GCP Workload Identity Provider to use as spec.gcp.workloadIdentityProviderID of your cloud access config when enabling cross-cloud access to GCP from AWS |
| <a name="output_gcp_workload_identity_provider_id_azure"></a> [gcp\_workload\_identity\_provider\_id\_azure](#output\_gcp\_workload\_identity\_provider\_id\_azure) | ID of GCP Workload Identity Provider to use as spec.gcp.workloadIdentityProviderID of your cloud access config when enabling cross-cloud access to GCP from Azure |
| <a name="output_network_manager_service_account"></a> [network\_manager\_service\_account](#output\_network\_manager\_service\_account) | Email of Network Manager service account to use as spec.permissions[].gcpServiceAccount on the NetworkManager permission of your cloud access config |
| <a name="output_peering_acceptor_service_account"></a> [peering\_acceptor\_service\_account](#output\_peering\_acceptor\_service\_account) | Email of Network Manager service account to use as spec.permissions[].gcpServiceAccount on the PeeringAcceptor permission of your cloud access config |

## Updating Docs

The `terraform-docs` utility is used to generate this README. Follow the below steps to update:
1. Make changes to the `.terraform-docs.yml` file
2. Fetch the `terraform-docs` binary (https://terraform-docs.io/user-guide/installation/)
3. Run `terraform-docs markdown table --output-file ${PWD}/README.md --output-mode inject .`
<!-- END_TF_DOCS -->