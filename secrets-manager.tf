# resource "ibm_resource_instance" "secrets_manager" {
#   name              = "${local.prefix}-secrets-manager"
#   service           = "secrets-manager"
#   plan              = "standard"
#   location          = var.ibmcloud_region
#   resource_group_id = module.resource_group.resource_group_id
#   tags              = local.tags

#   //User can increase timeouts
#   timeouts {
#     create = "30m"
#     update = "15m"
#     delete = "15m"
#   }
# }

resource "ibm_sm_secret_group" "sm_secret_group" {
  instance_id = data.ibm_resource_instance.secrets_manager.guid
  region      = var.ibmcloud_region
  name        = "${local.prefix}-vpn-secret-group"
  description = "Group for all VPN related secrets."
}

resource "ibm_sm_private_certificate_configuration_root_ca" "private_certificate_root_CA" {
  depends_on                        = [ibm_sm_secret_group.sm_secret_group]
  instance_id                       = data.ibm_resource_instance.secrets_manager.guid
  region                            = var.ibmcloud_region
  name                              = "${local.prefix}-vpn-root-ca"
  common_name                       = "${local.prefix}-vpn ca"
  max_ttl                           = "8760h"
  crl_disable                       = false
  country                           = ["US"]
  organization                      = ["IBM"]
  ou                                = ["Cloud"]
  locality                          = ["Houston"]
  key_type                          = "ec"
  key_bits                          = 384
  issuing_certificates_urls_encoded = true
}

resource "ibm_sm_private_certificate_configuration_intermediate_ca" "intermediate_CA" {
  depends_on                        = [ibm_sm_private_certificate_configuration_root_ca.private_certificate_root_CA]
  instance_id                       = data.ibm_resource_instance.secrets_manager.guid
  region                            = var.ibmcloud_region
  name                              = "${local.prefix}-vpn-intermediate-ca"
  common_name                       = "${local.prefix}-vpn ca"
  signing_method                    = "internal"
  issuer                            = "${local.prefix}-vpn-root-ca"
  max_ttl                           = "8760h"
  crl_disable                       = false
  country                           = ["US"]
  organization                      = ["IBM"]
  ou                                = ["Cloud"]
  locality                          = ["Houston"]
  key_type                          = "ec"
  key_bits                          = 384
  issuing_certificates_urls_encoded = true
}

resource "ibm_sm_private_certificate_configuration_template" "certificate_template" {
  depends_on            = [ibm_sm_private_certificate_configuration_intermediate_ca.intermediate_CA]
  instance_id           = data.ibm_resource_instance.secrets_manager.guid
  region                = var.ibmcloud_region
  name                  = "${local.prefix}-cert-template"
  certificate_authority = "${local.prefix}-vpn-intermediate-ca"
  allow_subdomains      = true
  allow_any_name        = true
}

resource "ibm_sm_private_certificate" "sm_private_certificate" {
  depends_on           = [ibm_sm_private_certificate_configuration_template.certificate_template]
  instance_id          = data.ibm_resource_instance.secrets_manager.guid
  region               = var.ibmcloud_region
  name                 = "${local.prefix}-vpn-server-cert"
  certificate_template = resource.ibm_sm_private_certificate_configuration_template.certificate_template.name
  common_name          = "vpn.example.com"
  secret_group_id      = ibm_sm_secret_group.sm_secret_group.secret_group_id
  ttl                  = "72h"
}

