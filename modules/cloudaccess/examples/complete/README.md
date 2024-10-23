<!-- BEGIN_TF_DOCS -->
## Providers

No providers.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enable_cloud_info"></a> [enable\_cloud\_info](#input\_enable\_cloud\_info) | Whether to create the Cloud Info service account | `bool` | `false` | no |
| <a name="input_enable_cluster_manager"></a> [enable\_cluster\_manager](#input\_enable\_cluster\_manager) | Whether to create the Cluster Manager service account | `bool` | `true` | no |
| <a name="input_enable_dns_zone_manager"></a> [enable\_dns\_zone\_manager](#input\_enable\_dns\_zone\_manager) | Whether to create the DNS Zone Manager service account | `bool` | `true` | no |
| <a name="input_enable_network_manager"></a> [enable\_network\_manager](#input\_enable\_network\_manager) | Whether to create the Network Manager service account | `bool` | `true` | no |
| <a name="input_enable_peering_acceptor"></a> [enable\_peering\_acceptor](#input\_enable\_peering\_acceptor) | Whether to create the Peering Acceptor service account | `bool` | `false` | no |
| <a name="input_from_aws"></a> [from\_aws](#input\_from\_aws) | Whether Wayfinder is running on AWS. | `bool` | `false` | no |
| <a name="input_from_azure"></a> [from\_azure](#input\_from\_azure) | Whether Wayfinder is running on Azure. | `bool` | `true` | no |
| <a name="input_from_gcp"></a> [from\_gcp](#input\_from\_gcp) | Whether Wayfinder is running on GCP. | `bool` | `false` | no |
| <a name="input_resource_suffix"></a> [resource\_suffix](#input\_resource\_suffix) | Suffix to apply to all generated resources. We recommend using workspace key + stage. | `string` | `""` | no |
| <a name="input_wayfinder_identity_aws_role_arn"></a> [wayfinder\_identity\_aws\_role\_arn](#input\_wayfinder\_identity\_aws\_role\_arn) | ARN of Wayfinder's identity to give access to. Populate when Wayfinder is running on AWS with IRSA. | `string` | `""` | no |
| <a name="input_wayfinder_identity_azure_client_id"></a> [wayfinder\_identity\_azure\_client\_id](#input\_wayfinder\_identity\_azure\_client\_id) | Client ID of Wayfinder's Azure AD managed identity to give access to. Populate when Wayfinder is running on Azure with AzureAD Workload Identity. | `string` | `""` | no |
| <a name="input_wayfinder_identity_azure_tenant_id"></a> [wayfinder\_identity\_azure\_tenant\_id](#input\_wayfinder\_identity\_azure\_tenant\_id) | Tenant ID of Wayfinder's Azure AD managed identity to give access to. Populate when Wayfinder is running on Azure with AzureAD Workload Identity. | `string` | `""` | no |
| <a name="input_wayfinder_identity_gcp_service_account"></a> [wayfinder\_identity\_gcp\_service\_account](#input\_wayfinder\_identity\_gcp\_service\_account) | Email address of Wayfinder's GCP service account to give access to. Populate when Wayfinder is running on GCP with Workload Identity. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloudaccess"></a> [cloudaccess](#output\_cloudaccess) | n/a |
<!-- END_TF_DOCS -->