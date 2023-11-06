<!-- BEGIN_TF_DOCS -->
# Terraform Module: Wayfinder on GCP

The "terraform-google-wayfinder" Terraform Module can be used to provision and manage a licensed edition of [Appvia Wayfinder](https://www.appvia.io/product/) on GCP.

## Requirements

To run this module, you will need the following:
1. Product Licence Key & Instance ID: Contact sales@appvia.io for more information.
2. (Optional) IDP App configuration details: Wayfinder integrates with an IDP for managing user access. You will need a valid Client ID, Client Secret and Server URL (or Azure Tenant ID) for setup. This does not need to be defined initially within Terraform, and can also be setup within the product. Wayfinder can provision a `localadmin` user for initial access if no IDP details are provided.
3. A public Google DNS Zone: This module will create DNS records for the Wayfinder API and UI endpoints, and performs a DNS01 challenge via the LetsEncrypt Issuer for valid domain certificates.
4. Existing Virtual Network and Subnet: This module will deploy a GKE Cluster and so requires an existing vnet with outbound internet connectivity.

## Deployment

Please see the [examples](./examples) directory to see how to deploy this module. To get up and running quickly with minimal pre-requisites, use the [quickstart](./examples/quickstart) example.

### (Optional) Connecting to an Identity Provider

Wayfinder integrates with an IDP for managing user access. You will need a valid Client ID, Client Secret and Server URL (or Azure Tenant ID).

This configuration is optional within Terraform, and can also be setup within the product. Please view the documentation for more information: https://docs.appvia.io/wayfinder/admin/auth

The Authorized Redirect URI for the IDP Application should be set to: `https://${wayfinder_domain_name_api}/oauth/callback`

**Note:** If you are using Azure Active Directory, you must:
1. Set `azureTenantId` to your Azure Tenant ID (`serverUrl` is not required)
2. Set the IDP type to `aad`

#### Example: Generic IDP Configuration

```hcl
wayfinder_idp_details = {
  type         = "generic"
  clientId     = "IDP-APP-CLIENT-ID"
  clientSecret = "IDP-APP-CLIENT-SECRET"
  serverUrl    = "https://example.okta.com" # Or "https://example.auth0.com/"
}
```

#### Example: Azure AD IDP Configuration

```hcl
wayfinder_idp_details = {
  type          = "aad"
  clientId      = "IDP-APP-CLIENT-ID"
  clientSecret  = "IDP-APP-CLIENT-SECRET"
  azureTenantId = "12345678-1234-1234-1234-123456789012"
}
```

## Updating Docs

The `terraform-docs` utility is used to generate this README. Follow the below steps to update:
1. Make changes to the `.terraform-docs.yml` file
2. Fetch the `terraform-docs` binary (https://terraform-docs.io/user-guide/installation/)
3. Run `terraform-docs markdown table --output-file ${PWD}/README.md --output-mode inject .`

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_endpoint_public_access_cidrs"></a> [cluster\_endpoint\_public\_access\_cidrs](#input\_cluster\_endpoint\_public\_access\_cidrs) | List of CIDR blocks which can access the GKE API master endpoint. | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_clusterissuer_email"></a> [clusterissuer\_email](#input\_clusterissuer\_email) | The email address to use for the cert-manager cluster issuer. | `string` | n/a | yes |
| <a name="input_create_localadmin_user"></a> [create\_localadmin\_user](#input\_create\_localadmin\_user) | Whether to create a localadmin user for access to the Wayfinder Portal and API. | `bool` | `true` | no |
| <a name="input_disable_internet_access"></a> [disable\_internet\_access](#input\_disable\_internet\_access) | Whether to disable internet access for GKE and the Wayfinder ingress controller. | `bool` | `false` | no |
| <a name="input_disable_local_login"></a> [disable\_local\_login](#input\_disable\_local\_login) | Whether to disable local login for Wayfinder. Note: An IDP must be configured within Wayfinder, otherwise you will not be able to log in. | `bool` | `false` | no |
| <a name="input_enable_k8s_resources"></a> [enable\_k8s\_resources](#input\_enable\_k8s\_resources) | Whether to enable the creation of Kubernetes resources for Wayfinder (helm and kubectl manifest deployments). | `bool` | `true` | no |
| <a name="input_enable_wf_cloudaccess"></a> [enable\_wf\_cloudaccess](#input\_enable\_wf\_cloudaccess) | Whether to configure CloudIdentity and admin CloudAccessConfig resources in Wayfinder once installed (requires enable\_k8s\_resources) | `bool` | `true` | no |
| <a name="input_enable_wf_costestimates"></a> [enable\_wf\_costestimates](#input\_enable\_wf\_costestimates) | Whether to configure admin CloudAccessConfig for cost estimates in the account Wayfinder is installed in once installed (requires enable\_k8s\_resources and enable\_wf\_cloudaccess) | `bool` | `true` | no |
| <a name="input_enable_wf_dnszonemanager"></a> [enable\_wf\_dnszonemanager](#input\_enable\_wf\_dnszonemanager) | Whether to configure admin CloudAccessConfig for DNS zone management in the account Wayfinder is installed in once installed (requires enable\_k8s\_resources and enable\_wf\_cloudaccess) | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment name we are provisioning. | `string` | `"production"` | no |
| <a name="input_gcp_network_name"></a> [gcp\_network\_name](#input\_gcp\_network\_name) | Google Compute Engine network to which the cluster is connected. | `string` | n/a | yes |
| <a name="input_gcp_project"></a> [gcp\_project](#input\_gcp\_project) | Google Cloud Platform Project ID. | `string` | n/a | yes |
| <a name="input_gcp_region"></a> [gcp\_region](#input\_gcp\_region) | Google Cloud region. | `string` | n/a | yes |
| <a name="input_gcp_subnetwork_name"></a> [gcp\_subnetwork\_name](#input\_gcp\_subnetwork\_name) | The name or self\_link of the Google Compute Engine subnetwork in which the cluster's instances are launched. | `string` | n/a | yes |
| <a name="input_gke_nodes_machine_type"></a> [gke\_nodes\_machine\_type](#input\_gke\_nodes\_machine\_type) | The instance types to use for the GKE managed node pool. | `string` | `"e2-medium"` | no |
| <a name="input_gke_nodes_minimum_size"></a> [gke\_nodes\_minimum\_size](#input\_gke\_nodes\_minimum\_size) | The minimum size to use for the GKE managed node pool. | `number` | `2` | no |
| <a name="input_gke_release_channel"></a> [gke\_release\_channel](#input\_gke\_release\_channel) | The release channel to use for GKE. | `string` | `"UNSPECIFIED"` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | A map of labels to add to all resources created. | `map(string)` | `{}` | no |
| <a name="input_pods_subnetwork_range_name"></a> [pods\_subnetwork\_range\_name](#input\_pods\_subnetwork\_range\_name) | The name of the existing secondary range in the cluster's subnetwork to use for pod IP addresses. | `string` | n/a | yes |
| <a name="input_services_subnetwork_range_name"></a> [services\_subnetwork\_range\_name](#input\_services\_subnetwork\_range\_name) | The name of the existing secondary range in the cluster's subnetwork to use for services IP addresses. | `string` | n/a | yes |
| <a name="input_wayfinder_domain_name_api"></a> [wayfinder\_domain\_name\_api](#input\_wayfinder\_domain\_name\_api) | The domain name to use for the Wayfinder API (e.g. api.wayfinder.example.com). | `string` | n/a | yes |
| <a name="input_wayfinder_domain_name_ui"></a> [wayfinder\_domain\_name\_ui](#input\_wayfinder\_domain\_name\_ui) | The domain name to use for the Wayfinder UI (e.g. portal.wayfinder.example.com). | `string` | n/a | yes |
| <a name="input_wayfinder_idp_details"></a> [wayfinder\_idp\_details](#input\_wayfinder\_idp\_details) | The IDP details to use for Wayfinder to enable SSO. | <pre>object({<br>    type          = string<br>    clientId      = optional(string)<br>    clientSecret  = optional(string)<br>    serverUrl     = optional(string)<br>    azureTenantId = optional(string)<br>  })</pre> | <pre>{<br>  "azureTenantId": "",<br>  "clientId": null,<br>  "clientSecret": null,<br>  "serverUrl": "",<br>  "type": "none"<br>}</pre> | no |
| <a name="input_wayfinder_instance_id"></a> [wayfinder\_instance\_id](#input\_wayfinder\_instance\_id) | The instance ID to use for Wayfinder. | `string` | n/a | yes |
| <a name="input_wayfinder_licence_key"></a> [wayfinder\_licence\_key](#input\_wayfinder\_licence\_key) | The licence key to use for Wayfinder. | `string` | n/a | yes |
| <a name="input_wayfinder_release_channel"></a> [wayfinder\_release\_channel](#input\_wayfinder\_release\_channel) | The release channel to use for Wayfinder. | `string` | `"wayfinder-releases"` | no |
| <a name="input_wayfinder_version"></a> [wayfinder\_version](#input\_wayfinder\_version) | The version to use for Wayfinder. | `string` | `"v2.4.0"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_ca_certificate"></a> [cluster\_ca\_certificate](#output\_cluster\_ca\_certificate) | GKE cluster master endpoint CA certificate base64 encoded. |
| <a name="output_cluster_endpoint"></a> [cluster\_endpoint](#output\_cluster\_endpoint) | The endpoint for the Wayfinder GKE Kubernetes API. |
| <a name="output_wayfinder_admin_password"></a> [wayfinder\_admin\_password](#output\_wayfinder\_admin\_password) | The password for the Wayfinder local admin user. |
| <a name="output_wayfinder_admin_username"></a> [wayfinder\_admin\_username](#output\_wayfinder\_admin\_username) | The username for the Wayfinder local admin user. |
| <a name="output_wayfinder_api_url"></a> [wayfinder\_api\_url](#output\_wayfinder\_api\_url) | The URL for the Wayfinder API. |
| <a name="output_wayfinder_instance_id"></a> [wayfinder\_instance\_id](#output\_wayfinder\_instance\_id) | The unique identifier for the Wayfinder instance. |
| <a name="output_wayfinder_service_account"></a> [wayfinder\_service\_account](#output\_wayfinder\_service\_account) | The GCP service account for Wayfinder admin. |
| <a name="output_wayfinder_ui_url"></a> [wayfinder\_ui\_url](#output\_wayfinder\_ui\_url) | The URL for the Wayfinder UI. |
<!-- END_TF_DOCS -->