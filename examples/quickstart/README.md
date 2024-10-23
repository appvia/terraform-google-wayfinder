# Example: Quickstart

**Notes:**

- Wayfinder will start up with an initial local administrator user (not configured to use an IDP).
- Terraform is not configured to use Cloud Storage as a backend, and so state will be written locally.
- Any sensitive values (e.g. licence key) are passed directly as a variable to the module.

## Deployment

1. Create a Cloud DNS Managed Zone in GCP and ensure the domain is delegated to the GCP nameservers.
2. Copy the `terraform.tfvars.example` file to `terraform.tfvars` and update with your values.
3. Run `terraform init -upgrade`
4. Run `terraform apply`

## Updating Docs

The `terraform-docs` utility is used to generate this README. Follow the below steps to update:

1. Make changes to the `.terraform-docs.yml` file
2. Fetch the `terraform-docs` binary (https://terraform-docs.io/user-guide/installation/)
3. Run `terraform-docs markdown table --output-file ${PWD}/README.md --output-mode inject .`

<!-- BEGIN_TF_DOCS -->
## Providers

No providers.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_clusterissuer_email"></a> [clusterissuer\_email](#input\_clusterissuer\_email) | The email address to use for the cert-manager cluster issuer. | `string` | n/a | yes |
| <a name="input_gcp_project"></a> [gcp\_project](#input\_gcp\_project) | Google Cloud Platform Project ID. | `string` | n/a | yes |
| <a name="input_wayfinder_domain_name_api"></a> [wayfinder\_domain\_name\_api](#input\_wayfinder\_domain\_name\_api) | The local DNS host to use for Wayfinder API. | `string` | n/a | yes |
| <a name="input_wayfinder_domain_name_ui"></a> [wayfinder\_domain\_name\_ui](#input\_wayfinder\_domain\_name\_ui) | The local DNS host to use for Wayfinder Portal. | `string` | n/a | yes |
| <a name="input_wayfinder_instance_id"></a> [wayfinder\_instance\_id](#input\_wayfinder\_instance\_id) | The instance ID to use for Wayfinder. | `string` | n/a | yes |
| <a name="input_wayfinder_licence_key"></a> [wayfinder\_licence\_key](#input\_wayfinder\_licence\_key) | The licence key to use for Wayfinder. | `string` | n/a | yes |
| <a name="input_disable_internet_access"></a> [disable\_internet\_access](#input\_disable\_internet\_access) | Whether to disable internet access for EKS and the Wayfinder ingress controller. | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment name we are provisioning. | `string` | `"production"` | no |
| <a name="input_gcp_region"></a> [gcp\_region](#input\_gcp\_region) | Google Cloud region. | `string` | `"europe-west2"` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | A map of labels to add to all resources created. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_wayfinder_admin_password"></a> [wayfinder\_admin\_password](#output\_wayfinder\_admin\_password) | The password for the Wayfinder local admin user |
| <a name="output_wayfinder_admin_username"></a> [wayfinder\_admin\_username](#output\_wayfinder\_admin\_username) | The username for the Wayfinder local admin user |
| <a name="output_wayfinder_api_url"></a> [wayfinder\_api\_url](#output\_wayfinder\_api\_url) | The URL for the Wayfinder API |
| <a name="output_wayfinder_instance_id"></a> [wayfinder\_instance\_id](#output\_wayfinder\_instance\_id) | The unique identifier for the Wayfinder instance |
| <a name="output_wayfinder_ui_url"></a> [wayfinder\_ui\_url](#output\_wayfinder\_ui\_url) | The URL for the Wayfinder UI |
<!-- END_TF_DOCS -->

