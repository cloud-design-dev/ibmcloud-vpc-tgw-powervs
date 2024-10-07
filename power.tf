resource "ibm_pi_workspace" "workspace" {
  pi_name              = "${local.prefix}-powervs-workspace"
  pi_datacenter        = var.ibmcloud_region
  pi_resource_group_id = module.resource_group.resource_group_id
}

resource "ibm_pi_key" "power_sshkey" {
  depends_on           = [ibm_pi_workspace.workspace]
  pi_key_name          = "${local.prefix}-power-sshkey"
  pi_ssh_key           = tls_private_key.rsa.public_key_openssh
  pi_cloud_instance_id = ibm_pi_workspace.workspace.id
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


resource "ibm_pi_instance" "linux" {
  depends_on           = [ibm_pi_key.power_sshkey]
  pi_memory            = "2"
  pi_processors        = "0.25"
  pi_instance_name     = "${local.prefix}-power-vm"
  pi_proc_type         = "shared"
  pi_image_id          = var.power_image_id
  pi_key_pair_name     = "${local.prefix}-power-sshkey"
  pi_sys_type          = "s922"
  pi_cloud_instance_id = ibm_pi_workspace.workspace.id
  pi_pin_policy        = "none"
  pi_health_status     = "WARNING"
  pi_network {
    network_id = ibm_pi_network.power_network.network_id
  }
}
