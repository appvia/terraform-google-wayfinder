<!-- BEGIN_TF_DOCS -->
# Terraform Module:
This Terraform Module can be used to provision the service accounts used by wayfinder for cloudaccess on gcp

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enable_cloud_info"></a> [enable\_cloud\_info](#input\_enable\_cloud\_info) | Whether to create the Cloud Info service account | `bool` | `false` | no |
| <a name="input_enable_cluster_manager"></a> [enable\_cluster\_manager](#input\_enable\_cluster\_manager) | Whether to create the Cluster Manager service account | `bool` | `true` | no |
| <a name="input_enable_dns_zone_manager"></a> [enable\_dns\_zone\_manager](#input\_enable\_dns\_zone\_manager) | Whether to create the DNS Zone Manager service account | `bool` | `true` | no |
| <a name="input_enable_network_manager"></a> [enable\_network\_manager](#input\_enable\_network\_manager) | Whether to create the Network Manager service account | `bool` | `true` | no |
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
| <a name="output_dnszone_manager_service_account"></a> [dnszone\_manager\_service\_account](#output\_dnszone\_manager\_service\_account) | Email of DNS Zone Manager service account to use as spec.permissions[].gcpServiceAccount on the DNSZoneManager permission of your cloud access config |
| <a name="output_gcp_project"></a> [gcp\_project](#output\_gcp\_project) | Project Name of the GCP project to use as spec.gcp.project of your cloud access config |
| <a name="output_gcp_projectnumber"></a> [gcp\_projectnumber](#output\_gcp\_projectnumber) | Project Number of the GCP project to use as spec.gcp.projectNumber of your cloud access config when enabling cross-cloud access to GCP from AWS or Azure |
| <a name="output_gcp_workload_identity_pool_id"></a> [gcp\_workload\_identity\_pool\_id](#output\_gcp\_workload\_identity\_pool\_id) | ID of GCP Workload Identity Pool to use as spec.gcp.workloadIdentityPoolID of your cloud access config when enabling cross-cloud access to GCP from AWS or Azure |
| <a name="output_gcp_workload_identity_provider_id"></a> [gcp\_workload\_identity\_provider\_id](#output\_gcp\_workload\_identity\_provider\_id) | ID of GCP Workload Identity Provider to use as spec.gcp.workloadIdentityProviderID of your cloud access config when enabling cross-cloud access to GCP from AWS or Azure |
| <a name="output_network_manager_service_account"></a> [network\_manager\_service\_account](#output\_network\_manager\_service\_account) | Email of Network Manager service account to use as spec.permissions[].gcpServiceAccount on the NetworkManager permission of your cloud access config |
<!-- END_TF_DOCS -->