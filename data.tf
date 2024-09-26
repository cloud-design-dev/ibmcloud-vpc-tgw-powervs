data "ibm_iam_account_settings" "iam_account_settings" {}

data "ibm_is_zones" "regional" {
  region = var.ibmcloud_region
}

data "ibm_resource_instance" "secrets_manager" {
  name              = var.existing_secrets_manager_instance
  location          = var.secrets_manager_region
  resource_group_id = module.resource_group.resource_group_id
  service           = "secrets-manager"
}

data "ibm_is_image" "base" {
  name = var.compute_base_image
}

data "ibm_is_ssh_key" "sshkey" {
  name = var.existing_ssh_key
}

#data "ibm_pi_key" "ssh_key" {
#  depends_on           = [ibm_pi_workspace.workspace]
#  pi_key_name          = "${local.prefix}-power-key"
#  pi_cloud_instance_id = ibm_pi_workspace.workspace.id
#}

#data "ibm_pi_image" "centos_stream9" {
#  depends_on           = [ibm_pi_workspace.workspace]
#  pi_image_name        = "CentOS-Stream-9"
#  pi_cloud_instance_id = ibm_pi_workspace.workspace.id
#}

# centos_stream9
