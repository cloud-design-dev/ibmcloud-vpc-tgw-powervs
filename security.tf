module "add_rules_to_default_vpc_security_group" {
  depends_on                   = [ibm_is_vpc.vpc]
  source                       = "terraform-ibm-modules/security-group/ibm"
  add_ibm_cloud_internal_rules = true
  use_existing_security_group  = true
  existing_security_group_name = ibm_is_vpc.vpc.default_security_group_name
  security_group_rules = [
    {
      name      = "allow-https-vpn-inbound"
      direction = "inbound"
      tcp = {
        port_min = 443
        port_max = 443
      }
      remote = "0.0.0.0/0"
    },
    {
      name      = "allow-icmp-inbound"
      direction = "inbound"
      icmp = {
        type = 8
        code = 0
      }
      remote = "0.0.0.0/0"
    },
    {
      name      = "allow-ssh-vpn-inbound"
      direction = "inbound"
      tcp = {
        port_min = 22
        port_max = 22
      }
      remote = "0.0.0.0/0"
    }
  ]
  tags = local.tags
}