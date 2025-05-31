# ssl certificate configuration using let's encrypt (acme)

# generate a private key for the certificate
resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

# create a certificate signing request
resource "tls_cert_request" "this" {
  private_key_pem = tls_private_key.this.private_key_pem

  subject {
    common_name  = "${var.application}.${var.dns_zone.name}"
    organization = var.organization
  }

  dns_names = [
    "${var.application}.${var.dns_zone.name}",
    "www.${var.application}.${var.dns_zone.name}"
  ]
}

# acme registration (let's encrypt account)
resource "acme_registration" "this" {
  email_address   = var.organization_email
  account_key_pem = tls_private_key.this.private_key_pem
}

# request the certificate from let's encrypt
resource "acme_certificate" "this" {
  account_key_pem         = acme_registration.this.account_key_pem
  certificate_request_pem = tls_cert_request.this.cert_request_pem

  dns_challenge {
    provider = "azure"
    config = {
      AZURE_ZONE_NAME      = var.dns_zone.name
      AZURE_RESOURCE_GROUP = var.dns_zone.resource_group_name
    }
  }
}

