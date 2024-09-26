variable "ibmcloud_api_key" {
  description = "The IBM Cloud API key needed to deploy the VPC"
  type        = string
  sensitive   = true
}

variable "ibmcloud_region" {
  description = "The IBM Cloud region where the VPC, Power, and related resources will be deployed"
  type        = string
  default     = "us-south"
}

variable "project_prefix" {
  description = "The prefix to use for naming resources. If not provided, a random string will be generated."
  type        = string
  default     = ""
}

variable "existing_resource_group" {
  description = "The name of an existing resource group where the VPC will be deployed"
  type        = string
  default     = ""
}

variable "existing_secrets_manager_instance" {
  description = "The name of an existing Secrets Manager instance"
  type        = string
}

variable "vpn_client_cidr" {
  description = "CIDR block for VPN clients"
  type        = string
  default     = "172.16.0.0/22"
  # this needs a validation added to it to ensure it is a valid CIDR block for the /9 to /22 range as outlined in the UI when provisioning a VPN c2s instance. #TOD: ryan will add this validation
}

variable "classic_access" {
  description = "Whether to enable classic access for the VPC"
  type        = bool
  default     = false
}

variable "default_address_prefix" {
  description = "The default address prefix to use for the VPC"
  type        = string
  default     = "auto"
}

variable "power_zone" {
  description = "The zone to deploy the PowerVS instance"
  type        = string
  default     = "dal12"
}

variable "compute_base_image" {
  description = "The base image to use for the compute instance"
  type        = string
  default     = "ibm-ubuntu-22-04-4-minimal-amd64-4"
}

variable "existing_ssh_key" {
  description = "Name of an existing SSH key in the region."
  type        = string
  default     = ""
}

variable "compute_instance_profile" {
  description = "The profile to use for the compute instance"
  type        = string
  default     = "cx2-2x4"
}

