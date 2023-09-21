# terraform-gcp-wayfinder
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 4.82.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.9.0 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | >= 1.14.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.23.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.5 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.82.0 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.11.0 |
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | 1.14.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.23.0 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.5 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_container_cluster.gke](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster) | resource |
| [google_container_node_pool.nodes](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_node_pool) | resource |
| [google_project_iam_member.cert_manager](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.external_dns](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_service_account.cert_manager](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account.external_dns](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account.gke_service_account](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account.wayfinder](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account_iam_binding.cert_manager](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_iam_binding) | resource |
| [google_service_account_iam_binding.external_dns](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_iam_binding) | resource |
| [google_service_account_iam_binding.wayfinder_workload_identity_user](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_iam_binding) | resource |
| [helm_release.certmanager](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.external-dns](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.ingress](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.wayfinder](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubectl_manifest.certmanager_clusterissuer](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.storageclass](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.storageclass_encrypted](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.wayfinder_idp](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.wayfinder_idp_aad](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.wayfinder_namespace](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [random_id.cert_manager_sa_suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [random_id.external_dns_sa_suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [random_id.wayfinder_sa_suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [kubernetes_secret.localadmin_password](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/data-sources/secret) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_endpoint_public_access_cidrs"></a> [cluster\_endpoint\_public\_access\_cidrs](#input\_cluster\_endpoint\_public\_access\_cidrs) | List of CIDR blocks which can access the GKE API master endpoint | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_clusterissuer_email"></a> [clusterissuer\_email](#input\_clusterissuer\_email) | The email address to use for the cert-manager cluster issuer | `string` | n/a | yes |
| <a name="input_create_localadmin_user"></a> [create\_localadmin\_user](#input\_create\_localadmin\_user) | Whether to create a localadmin user for access to the Wayfinder Portal and API | `bool` | `true` | no |
| <a name="input_disable_internet_access"></a> [disable\_internet\_access](#input\_disable\_internet\_access) | Whether to disable internet access for GKE and the Wayfinder ingress controller | `bool` | `false` | no |
| <a name="input_enable_k8s_resources"></a> [enable\_k8s\_resources](#input\_enable\_k8s\_resources) | Whether to enable the creation of Kubernetes resources for Wayfinder (helm and kubectl manifest deployments) | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment name we are provisioning | `string` | `"production"` | no |
| <a name="input_gcp_network_name"></a> [gcp\_network\_name](#input\_gcp\_network\_name) | Google Compute Engine network to which the cluster is connected | `string` | n/a | yes |
| <a name="input_gcp_project"></a> [gcp\_project](#input\_gcp\_project) | Google Cloud Platform Project ID | `string` | n/a | yes |
| <a name="input_gcp_region"></a> [gcp\_region](#input\_gcp\_region) | Google Cloud region | `string` | n/a | yes |
| <a name="input_gcp_subnetwork_name"></a> [gcp\_subnetwork\_name](#input\_gcp\_subnetwork\_name) | The name or self\_link of the Google Compute Engine subnetwork in which the cluster's instances are launched. | `string` | n/a | yes |
| <a name="input_gke_nodes_machine_type"></a> [gke\_nodes\_machine\_type](#input\_gke\_nodes\_machine\_type) | The instance types to use for the GKE managed node pool | `string` | `"e2-medium"` | no |
| <a name="input_gke_nodes_minimum_size"></a> [gke\_nodes\_minimum\_size](#input\_gke\_nodes\_minimum\_size) | The minimum size to use for the GKE managed node pool | `number` | `3` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | A map of labels to add to all resources created | `map(string)` | `{}` | no |
| <a name="input_pods_subnetwork_range_name"></a> [pods\_subnetwork\_range\_name](#input\_pods\_subnetwork\_range\_name) | The name of the existing secondary range in the cluster's subnetwork to use for pod IP addresses. | `string` | n/a | yes |
| <a name="input_services_subnetwork_range_name"></a> [services\_subnetwork\_range\_name](#input\_services\_subnetwork\_range\_name) | The name of the existing secondary range in the cluster's subnetwork to use for services IP addresses. | `string` | n/a | yes |
| <a name="input_wayfinder_domain_name_api"></a> [wayfinder\_domain\_name\_api](#input\_wayfinder\_domain\_name\_api) | The domain name to use for the Wayfinder API (e.g. api.wayfinder.example.com) | `string` | n/a | yes |
| <a name="input_wayfinder_domain_name_ui"></a> [wayfinder\_domain\_name\_ui](#input\_wayfinder\_domain\_name\_ui) | The domain name to use for the Wayfinder UI (e.g. portal.wayfinder.example.com) | `string` | n/a | yes |
| <a name="input_wayfinder_idp_details"></a> [wayfinder\_idp\_details](#input\_wayfinder\_idp\_details) | The IDP details to use for Wayfinder to enable SSO | <pre>object({<br>    type          = string<br>    clientId      = optional(string)<br>    clientSecret  = optional(string)<br>    serverUrl     = optional(string)<br>    azureTenantId = optional(string)<br>  })</pre> | <pre>{<br>  "azureTenantId": "",<br>  "clientId": null,<br>  "clientSecret": null,<br>  "serverUrl": "",<br>  "type": "none"<br>}</pre> | no |
| <a name="input_wayfinder_instance_id"></a> [wayfinder\_instance\_id](#input\_wayfinder\_instance\_id) | The instance ID to use for Wayfinder. This can be left blank and will be autogenerated. | `string` | `""` | no |
| <a name="input_wayfinder_licence_key"></a> [wayfinder\_licence\_key](#input\_wayfinder\_licence\_key) | The licence key to use for Wayfinder | `string` | n/a | yes |
| <a name="input_wayfinder_release_channel"></a> [wayfinder\_release\_channel](#input\_wayfinder\_release\_channel) | The release channel to use for Wayfinder | `string` | `"wayfinder-releases"` | no |
| <a name="input_wayfinder_version"></a> [wayfinder\_version](#input\_wayfinder\_version) | The version to use for Wayfinder | `string` | `"v2.3.3"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_ca_certificate"></a> [cluster\_ca\_certificate](#output\_cluster\_ca\_certificate) | GKE cluster master endpoint CA certificate base64 encoded. |
| <a name="output_cluster_endpoint"></a> [cluster\_endpoint](#output\_cluster\_endpoint) | The endpoint for the Wayfinder GKE Kubernetes API |
| <a name="output_wayfinder_admin_password"></a> [wayfinder\_admin\_password](#output\_wayfinder\_admin\_password) | The password for the Wayfinder local admin user |
| <a name="output_wayfinder_admin_username"></a> [wayfinder\_admin\_username](#output\_wayfinder\_admin\_username) | The username for the Wayfinder local admin user |
| <a name="output_wayfinder_api_url"></a> [wayfinder\_api\_url](#output\_wayfinder\_api\_url) | The URL for the Wayfinder API |
| <a name="output_wayfinder_instance_identifier"></a> [wayfinder\_instance\_identifier](#output\_wayfinder\_instance\_identifier) | The unique identifier for the Wayfinder instance |
| <a name="output_wayfinder_service_account"></a> [wayfinder\_service\_account](#output\_wayfinder\_service\_account) | The GCP service account for wayfinder admin |
| <a name="output_wayfinder_ui_url"></a> [wayfinder\_ui\_url](#output\_wayfinder\_ui\_url) | The URL for the Wayfinder UI |
<!-- END_TF_DOCS -->