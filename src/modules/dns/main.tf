resource "aws_route53_zone" "domain_hosted_zone" {
  name = var.domain_name
}

resource "aws_route53_record" "domain_web" {
  zone_id = aws_route53_zone.domain_hosted_zone.zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    evaluate_target_health = false
    name                   = var.cloudfront_domain_name
    zone_id                = var.hosted_zone_id
  }
}

resource "aws_route53_record" "domain_web_www" {
  zone_id = aws_route53_zone.domain_hosted_zone.zone_id
  name    = "www.${var.domain_name}"
  type    = "A"

  alias {
    evaluate_target_health = false
    name                   = var.cloudfront_domain_name
    zone_id                = var.hosted_zone_id
  }
}

resource "aws_acm_certificate" "domain_certificate" {
  domain_name       = var.domain_name
  validation_method = "DNS"

  subject_alternative_names = ["*.${var.domain_name}"]

  lifecycle {
    create_before_destroy = true
  }
}
