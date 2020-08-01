locals {
  all_domains_list = [
    for host in concat([var.domain_name], var.mirror_domains) : host.domain
  ]
}

resource "aws_route53_record" "domain_web" {
  count = length(concat([var.domain_name], var.mirror_domains))

  zone_id = concat([var.domain_name], var.mirror_domains)[count.index].hosted_zone_id
  name    = concat([var.domain_name], var.mirror_domains)[count.index].domain
  type    = "A"

  alias {
    evaluate_target_health = false
    name                   = var.cloudfront_domain_name
    zone_id                = var.cloudfront_hosted_zone_id
  }
}

resource "aws_acm_certificate" "domain_certificate" {
  domain_name       = var.domain_name.domain
  validation_method = "DNS"

  subject_alternative_names = concat(
    local.all_domains_list,
    formatlist("*.%s", local.all_domains_list)
  )

  lifecycle {
    create_before_destroy = true
  }
}
