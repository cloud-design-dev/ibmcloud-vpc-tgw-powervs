<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_ibm"></a> [ibm](#requirement\_ibm) | 1.70.0-beta0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_ibm"></a> [ibm](#provider\_ibm) | 1.70.0-beta0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.6.3 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_add_rules_to_default_vpc_security_group"></a> [add\_rules\_to\_default\_vpc\_security\_group](#module\_add\_rules\_to\_default\_vpc\_security\_group) | terraform-ibm-modules/security-group/ibm | n/a |
| <a name="module_resource_group"></a> [resource\_group](#module\_resource\_group) | terraform-ibm-modules/resource-group/ibm | 1.1.5 |

## Resources

| Name | Type |
|------|------|
| [ibm_iam_authorization_policy.secret_group_to_vpn](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.70.0-beta0/docs/resources/iam_authorization_policy) | resource |
| [ibm_is_instance.compute](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.70.0-beta0/docs/resources/is_instance) | resource |
| [ibm_is_public_gateway.gateway](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.70.0-beta0/docs/resources/is_public_gateway) | resource |
| [ibm_is_subnet.vpn](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.70.0-beta0/docs/resources/is_subnet) | resource |
| [ibm_is_virtual_network_interface.compute](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.70.0-beta0/docs/resources/is_virtual_network_interface) | resource |
| [ibm_is_vpc.vpc](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.70.0-beta0/docs/resources/is_vpc) | resource |
| [ibm_is_vpn_server.client_to_site](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.70.0-beta0/docs/resources/is_vpn_server) | resource |
| [ibm_is_vpn_server_route.internet](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.70.0-beta0/docs/resources/is_vpn_server_route) | resource |
| [ibm_is_vpn_server_route.vpc](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.70.0-beta0/docs/resources/is_vpn_server_route) | resource |
| [ibm_pi_network.power_network](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.70.0-beta0/docs/resources/pi_network) | resource |
| [ibm_pi_workspace.workspace](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.70.0-beta0/docs/resources/pi_workspace) | resource |
| [ibm_sm_private_certificate.sm_private_certificate](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.70.0-beta0/docs/resources/sm_private_certificate) | resource |
| [ibm_sm_private_certificate_configuration_intermediate_ca.intermediate_CA](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.70.0-beta0/docs/resources/sm_private_certificate_configuration_intermediate_ca) | resource |
| [ibm_sm_private_certificate_configuration_root_ca.private_certificate_root_CA](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.70.0-beta0/docs/resources/sm_private_certificate_configuration_root_ca) | resource |
| [ibm_sm_private_certificate_configuration_template.certificate_template](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.70.0-beta0/docs/resources/sm_private_certificate_configuration_template) | resource |
| [ibm_sm_secret_group.sm_secret_group](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.70.0-beta0/docs/resources/sm_secret_group) | resource |
| [ibm_tg_connection.power](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.70.0-beta0/docs/resources/tg_connection) | resource |
| [ibm_tg_connection.vpc](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.70.0-beta0/docs/resources/tg_connection) | resource |
| [ibm_tg_gateway.local](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.70.0-beta0/docs/resources/tg_gateway) | resource |
| [random_string.prefix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [ibm_iam_account_settings.iam_account_settings](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.70.0-beta0/docs/data-sources/iam_account_settings) | data source |
| [ibm_is_image.base](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.70.0-beta0/docs/data-sources/is_image) | data source |
| [ibm_is_ssh_key.sshkey](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.70.0-beta0/docs/data-sources/is_ssh_key) | data source |
| [ibm_is_zones.regional](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.70.0-beta0/docs/data-sources/is_zones) | data source |
| [ibm_resource_instance.secrets_manager](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.70.0-beta0/docs/data-sources/resource_instance) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_classic_access"></a> [classic\_access](#input\_classic\_access) | Whether to enable classic access for the VPC | `bool` | `false` | no |
| <a name="input_compute_base_image"></a> [compute\_base\_image](#input\_compute\_base\_image) | The base image to use for the compute instance | `string` | `"ibm-ubuntu-22-04-4-minimal-amd64-4"` | no |
| <a name="input_compute_instance_profile"></a> [compute\_instance\_profile](#input\_compute\_instance\_profile) | The profile to use for the compute instance | `string` | `"cx2-2x4"` | no |
| <a name="input_default_address_prefix"></a> [default\_address\_prefix](#input\_default\_address\_prefix) | The default address prefix to use for the VPC | `string` | `"auto"` | no |
| <a name="input_existing_resource_group"></a> [existing\_resource\_group](#input\_existing\_resource\_group) | The name of an existing resource group where the VPC will be deployed | `string` | `""` | no |
| <a name="input_existing_secrets_manager_instance"></a> [existing\_secrets\_manager\_instance](#input\_existing\_secrets\_manager\_instance) | The name of an existing Secrets Manager instance | `string` | n/a | yes |
| <a name="input_existing_ssh_key"></a> [existing\_ssh\_key](#input\_existing\_ssh\_key) | Name of an existing SSH key in the region. | `string` | `""` | no |
| <a name="input_ibmcloud_api_key"></a> [ibmcloud\_api\_key](#input\_ibmcloud\_api\_key) | The IBM Cloud API key needed to deploy the VPC | `string` | n/a | yes |
| <a name="input_ibmcloud_region"></a> [ibmcloud\_region](#input\_ibmcloud\_region) | The IBM Cloud region where the VPC, Power, and related resources will be deployed | `string` | `"us-south"` | no |
| <a name="input_power_zone"></a> [power\_zone](#input\_power\_zone) | The zone to deploy the PowerVS instance | `string` | `"dal12"` | no |
| <a name="input_project_prefix"></a> [project\_prefix](#input\_project\_prefix) | The prefix to use for naming resources. If not provided, a random string will be generated. | `string` | `""` | no |
| <a name="input_vpn_client_cidr"></a> [vpn\_client\_cidr](#input\_vpn\_client\_cidr) | CIDR block for VPN clients | `string` | `"172.16.0.0/22"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_power_network"></a> [power\_network](#output\_power\_network) | n/a |
| <a name="output_power_workspace"></a> [power\_workspace](#output\_power\_workspace) | n/a |
<!-- END_TF_DOCS -->