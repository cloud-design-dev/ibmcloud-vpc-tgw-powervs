resource "ibm_pi_workspace" "workspace" {
  pi_name              = "${local.prefix}-powervs-workspace"
  pi_datacenter        = var.ibmcloud_region
  pi_resource_group_id = module.resource_group.resource_group_id
}

resource "ibm_pi_network" "power_network" {
  pi_network_name      = "${local.prefix}-powervs-network"
  pi_cloud_instance_id = ibm_pi_workspace.workspace.id
  pi_network_type      = "vlan"
  pi_cidr              = "172.16.0.0/24"
  pi_dns               = ["1.1.1.1"]
  pi_gateway           = "172.16.0.1"
  pi_ipaddress_range {
    pi_starting_ip_address = "172.16.0.2"
    pi_ending_ip_address   = "172.16.0.100"
  }
}
