terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}



resource "aws_acm_certificate" "application" {
  domain_name               = var.domain_name
  validation_method         = "DNS"
  subject_alternative_names = var.alternative_names
  tags                      = var.tags

  lifecycle {
    create_before_destroy = true
  }
}

# Create DNS Validation Records in Cloudflare
resource "cloudflare_record" "cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.application.domain_validation_options :
    dvo.domain_name => {
      name  = dvo.resource_record_name
      type  = dvo.resource_record_type
      value = dvo.resource_record_value
    }
  }

  zone_id = var.cloudflare_zone_id
  name    = each.value.name
  type    = each.value.type
  content = each.value.value
  ttl     = 300
  proxied = false
}

resource "aws_acm_certificate_validation" "application" {
  certificate_arn = aws_acm_certificate.application.arn

  validation_record_fqdns = [
    for record in cloudflare_record.cert_validation : record.hostname
  ]
}