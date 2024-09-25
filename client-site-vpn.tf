

resource "ibm_iam_authorization_policy" "secret_group_to_vpn" {
  subject_attributes {
    name  = "accountId"
    value = data.ibm_iam_account_settings.iam_account_settings.account_id
  }

  subject_attributes {
    name  = "serviceName"
    value = "is"
  }

  subject_attributes {
    name  = "resourceType"
    value = "vpn-server"
  }

  roles = ["SecretsReader"]

  resource_attributes {
    name  = "accountId"
    value = data.ibm_iam_account_settings.iam_account_settings.account_id
  }

  resource_attributes {
    name  = "serviceName"
    value = "secrets-manager"
  }

  resource_attributes {
    name  = "resourceType"
    value = "secret-group"
  }

  resource_attributes {
    name  = "resource"
    value = ibm_sm_secret_group.sm_secret_group.secret_group_id
  }
}

resource "ibm_is_vpn_server" "client_to_site" {
  depends_on      = [ibm_sm_private_certificate.sm_private_certificate]
  certificate_crn = ibm_sm_private_certificate.sm_private_certificate.crn
  client_authentication {
    method            = "username"
    identity_provider = "iam"
  }

  client_ip_pool         = "192.168.0.0/22"
  client_idle_timeout    = 2800
  enable_split_tunneling = true
  name                   = "client-to-site-vpn-server"
  port                   = 443
  protocol               = "tcp"
  subnets                = [ibm_is_subnet.vpn.id]
}

resource "ibm_is_vpn_server_route" "internet" {
  vpn_server  = ibm_is_vpn_server.client_to_site.vpn_server
  destination = "0.0.0.0/0"
  action      = "deliver"
  name        = "internet-vpn-server-route"
}

resource "ibm_is_vpn_server_route" "vpc" {
  vpn_server  = ibm_is_vpn_server.client_to_site.vpn_server
  destination = ibm_is_subnet.vpn.ipv4_cidr_block
  action      = "deliver"
  name        = "vpc-vpn-server-route"
}

