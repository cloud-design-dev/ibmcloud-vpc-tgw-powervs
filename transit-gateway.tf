resource "ibm_tg_gateway" "local" {
  depends_on     = [ibm_is_vpc.vpc]
  name           = "${local.prefix}-local-tgw"
  location       = var.ibmcloud_region
  global         = false
  resource_group = module.resource_group.resource_group_id
}


resource "ibm_tg_connection" "vpc" {
  depends_on   = [ibm_tg_gateway.local]
  gateway      = ibm_tg_gateway.local.id
  network_type = "vpc"
  name         = "${local.prefix}-vpc-connection"
  network_id   = ibm_is_vpc.vpc.crn
}

resource "ibm_tg_connection" "power" {
  depends_on   = [ibm_tg_gateway.local]
  gateway      = ibm_tg_gateway.local.id
  network_type = "power_virtual_server"
  name         = "${local.prefix}-power-connection"
  network_id   = local.power_network_id
}

