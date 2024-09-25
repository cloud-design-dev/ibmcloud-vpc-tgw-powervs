data "ibm_iam_account_settings" "iam_account_settings" {}

data "ibm_is_zones" "regional" {
  region = var.ibmcloud_region
}

data "ibm_resource_instance" "secrets_manager" {
  name              = var.existing_secrets_manager_instance
  location          = var.ibmcloud_region
  resource_group_id = module.resource_group.resource_group_id
  service           = "secrets-manager"
}

data "ibm_is_image" "base" {
  name = var.compute_base_image
}

data "ibm_is_ssh_key" "sshkey" {
  name = var.existing_ssh_key
}
