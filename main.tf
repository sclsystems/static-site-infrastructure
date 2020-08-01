module "distribution" {
  source                      = "./modules/distribution"
  domain_name                 = var.domain_name
  domain_name_certificate_arn = module.dns.domain_certificate_arn
  cloudfront_refer_secret     = var.cloudfront_refer_secret
  mirror_domains              = var.mirror_domains
}

module "dns" {
  source                    = "./modules/dns"
  domain_name               = var.domain_name
  cloudfront_hosted_zone_id = module.distribution.cloudfront_hosted_zone_id
  cloudfront_domain_name    = module.distribution.cloudfront_domain_name
  mirror_domains            = var.mirror_domains
}

module "integration" {
  source                     = "./modules/integration"
  s3_bucket                  = module.distribution.s3_bucket
  project_name               = var.project_name
  cloudfront_distribution_id = module.distribution.cloudfront_distribution_id
  git_repository             = var.git_repository
  domain_name                = var.domain_name
  buildspec_location         = var.buildspec_location
}
