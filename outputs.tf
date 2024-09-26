output "power_network_id" {
  value = ibm_pi_network.power_network.network_id
}

output "power_workspace_id" {
  value = ibm_pi_workspace.workspace.id
}

output "vpc_instance_ip" {
  value = ibm_is_virtual_network_interface.compute.primary_ip[0].address
}

output "power_instance_ip" {
  value = ibm_pi_instance.linux.pi_network[0].ip_address
}
