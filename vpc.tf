resource "ibm_is_vpc" "vpc" {
  name                        = "${local.prefix}-vpc"
  resource_group              = module.resource_group.resource_group_id
  classic_access              = var.classic_access
  address_prefix_management   = var.default_address_prefix
  default_network_acl_name    = "${local.prefix}-default-nacl"
  default_security_group_name = "${local.prefix}-default-sg"
  default_routing_table_name  = "${local.prefix}-default-rt"
  tags                        = local.tags
}

resource "ibm_is_public_gateway" "gateway" {
  name           = "${local.prefix}-${local.vpc_zones[0].zone}-pgw"
  resource_group = module.resource_group.resource_group_id
  vpc            = ibm_is_vpc.vpc.id
  zone           = local.vpc_zones[0].zone
  tags           = concat(local.tags, ["zone:${local.vpc_zones[0].zone}"])
}

resource "ibm_is_subnet" "vpn" {
  name                     = "${local.prefix}-vpn-subnet"
  resource_group           = module.resource_group.resource_group_id
  vpc                      = ibm_is_vpc.vpc.id
  zone                     = local.vpc_zones[0].zone
  total_ipv4_address_count = "32"
  public_gateway           = ibm_is_public_gateway.gateway.id
  tags                     = concat(local.tags, ["zone:${local.vpc_zones[0].zone}"])
}




resource "ibm_is_virtual_network_interface" "compute" {
  allow_ip_spoofing         = true
  auto_delete               = false
  enable_infrastructure_nat = true
  name                      = "${local.prefix}-vnic"
  subnet                    = ibm_is_subnet.vpn.id
  resource_group            = module.resource_group.resource_group_id
  security_groups           = [ibm_is_vpc.vpc.default_security_group]
  tags                      = concat(local.tags, ["zone:${local.vpc_zones[0].zone}"])
}

resource "ibm_is_instance" "compute" {
  name           = "${local.prefix}-compute"
  vpc            = ibm_is_vpc.vpc.id
  image          = data.ibm_is_image.base.id
  profile        = var.compute_instance_profile
  resource_group = module.resource_group.resource_group_id
  metadata_service {
    enabled            = true
    protocol           = "https"
    response_hop_limit = 5
  }

  boot_volume {
    auto_delete_volume = true
  }

  primary_network_attachment {
    name = "${local.prefix}-primary-interface"
    virtual_network_interface {
      id = ibm_is_virtual_network_interface.compute.id
    }
  }

  zone = local.vpc_zones[0].zone
  keys = [data.ibm_is_ssh_key.sshkey.id]
  tags = concat(local.tags, ["zone:${local.vpc_zones[0].zone}"])
}

resource "ibm_is_vpc_routing_table" "vpn_routing_table" {
  vpc                              = ibm_is_vpc.vpc.id
  name                             = "${local.prefix}-vpc-tgw-routing-table"
  route_direct_link_ingress        = false
  route_transit_gateway_ingress    = true
  route_vpc_zone_ingress           = false
  accept_routes_from_resource_type = ["vpn_server"]
  advertise_routes_to              = ["transit_gateway"]
}

# a new route table
# accepts from the VPN server
# advertises tgw route