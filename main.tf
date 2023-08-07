provider "aws" {
  region = var.aws_region
}

resource "aws_ses_domain_identity" "default" {
  count  = var.enable_domain ? 1 : 0
  domain = var.domain
}

resource "aws_ses_domain_identity_verification" "default" {
  count = var.enable_domain_verification ? 1 : 0

  domain = aws_ses_domain_identity.default[0].domain
}

resource "aws_ses_email_identity" "default" {
  count = length(var.emails)

  email = var.emails[count.index]
}

resource "aws_ses_configuration_set" "default" {
  name = var.ses_configuration_set_name
}

output "ses_domain_identity" {
  value = aws_ses_domain_identity.default[0].domain
}

output "ses_configuration_set_name" {
  value = aws_ses_configuration_set.default.name
}
