locals {
  prefix = var.project_prefix != "" ? var.project_prefix : "${random_string.prefix.0.result}"
  zones  = length(data.ibm_is_zones.regional.zones)
  vpc_zones = {
    for zone in range(local.zones) : zone => {
      zone = "${var.ibmcloud_region}-${zone + 1}"
    }
  }

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

resource "ibm_iam_access_group" "vpn" {
  name        = "${local.prefix}-vpn-access-group"
  description = "For Client to Site VPN users"
}

resource "ibm_iam_access_group_policy" "vpn_policy" {
  access_group_id = ibm_iam_access_group.vpn.id


  resource_attributes {
    name     = "serviceName"
    value    = "is"
    operator = "stringEquals"
  }

  roles = ["VPN Client"]
}

resource "ibm_iam_access_group_members" "vpn_members" {
  count           = length(var.vpn_users) > 0 ? 1 : 0
  access_group_id = ibm_iam_access_group.vpn.id
  ibm_ids         = var.vpn_users
}

resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

