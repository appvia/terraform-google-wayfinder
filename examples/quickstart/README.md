# Example: Quickstart

**Notes:**

- Wayfinder will start up with an initial local administrator user (not configured to use an IDP).
- Terraform is not configured to use Cloud Storage as a backend, and so state will be written locally.
- Any sensitive values (e.g. licence key) are passed directly as a variable to the module.

This example should be used for product testing and evaluation only. For a more production-ready deployment, please see the [complete example](../complete).

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
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 4.82 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | ~> 2.9.0 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | >= 1.14.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 2.23.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_network"></a> [network](#module\_network) | terraform-google-modules/network/google | ~> 7.3 |
| <a name="module_wayfinder"></a> [wayfinder](#module\_wayfinder) | /home/vaijab/work/appvia/git/terraform-gcp-wayfinder | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_clusterissuer_email"></a> [clusterissuer\_email](#input\_clusterissuer\_email) | The email address to use for the cert-manager cluster issuer. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment name we are provisioning. | `string` | `"production"` | no |
| <a name="input_wayfinder_domain_name_api"></a> [wayfinder\_domain\_name\_api](#input\_wayfinder\_domain\_name\_api) | The local DNS host to use for Wayfinder API. | `string` | n/a | yes |
| <a name="input_wayfinder_domain_name_ui"></a> [wayfinder\_domain\_name\_ui](#input\_wayfinder\_domain\_name\_ui) | The local DNS host to use for Wayfinder Portal. | `string` | n/a | yes |
| <a name="input_wayfinder_instance_id"></a> [wayfinder\_instance\_id](#input\_wayfinder\_instance\_id) | The instance ID to use for Wayfinder. | `string` | n/a | yes |
| <a name="input_wayfinder_licence_key"></a> [wayfinder\_licence\_key](#input\_wayfinder\_licence\_key) | The licence key to use for Wayfinder. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
