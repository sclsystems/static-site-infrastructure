module "static_site_infrastruture" {
  source = "./src"

  domain_name             = var.domain_name
  project_name            = var.project_name
  git_repository          = var.git_repository
  buildspec_location      = var.buildspec_location
  domain_hosted_zone_id   = var.domain_hosted_zone_id
  cloudfront_refer_secret = var.cloudfront_refer_secret
}
