locals {
  # Get distinct list of domains and SANs
  distinct_domain_names = distinct(
    [for s in concat([var.domain_name], var.subject_alternative_names) : replace(s, "*.", "")]
  )

  # Copy domain_validation_options for the distinct domain names
  validation_domains = [for k, v in aws_acm_certificate.this.domain_validation_options : tomap(v)]
}

resource "aws_acm_certificate" "this" {
  domain_name               = var.domain_name
  subject_alternative_names = var.subject_alternative_names

  validation_method = var.validation_method

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "validation" {
  count = var.validation_method == "DNS" ? length(local.distinct_domain_names) : 0

  zone_id = var.zone_id
  name    = element(local.validation_domains, count.index)["resource_record_name"]
  type    = element(local.validation_domains, count.index)["resource_record_type"]
  ttl     = var.dns_ttl

  records = [
    element(local.validation_domains, count.index)["resource_record_value"]
  ]

  allow_overwrite = var.validation_allow_overwrite_records

  depends_on = [aws_acm_certificate.this]
}

resource "aws_acm_certificate_validation" "this" {
  count = var.validation_method == "DNS" && var.wait_for_validation ? 1 : 0

  certificate_arn = aws_acm_certificate.this.arn

  validation_record_fqdns = length(var.validation_record_fqdns) == 0 ? aws_route53_record.validation.*.fqdn : var.validation_record_fqdns
}

output "arn" {
  value = aws_acm_certificate.this.arn
}
