locals {
  prefix = var.project_prefix != "" ? var.project_prefix : "${random_string.prefix.0.result}"
  zones  = length(data.ibm_is_zones.regional.zones)
  vpc_zones = {
    for zone in range(local.zones) : zone => {
      zone = "${var.ibmcloud_region}-${zone + 1}"
    }
  }
  power_network_id = "crn:v1:bluemix:public:power-iaas:${var.ibmcloud_region}:a/${data.ibm_iam_account_settings.iam_account_settings.account_id}:${ibm_pi_workspace.workspace.id}::"
  tags = [
    "provider:ibm",
    "region:${var.ibmcloud_region}"
  ]
}

# # If no project prefix is defined, generate a random one 
resource "random_string" "prefix" {
  count   = var.project_prefix != "" ? 0 : 1
  length  = 4
  special = false
  numeric = false
  upper   = false
}

# If an existing resource group is provided, this module returns the ID, otherwise it creates a new one and returns the ID
module "resource_group" {
  source                       = "terraform-ibm-modules/resource-group/ibm"
  version                      = "1.1.5"
  resource_group_name          = var.existing_resource_group == null ? "${local.prefix}-resource-group" : null
  existing_resource_group_name = var.existing_resource_group
}

