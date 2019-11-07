module "static_site_infrastruture" {
  source = "./src"

  aws_region              = var.aws_region
  domain_name             = var.domain_name
  project_name            = var.project_name
  git_repository          = var.git_repository
  buildspec_location      = var.buildspec_location
  cloudfront_refer_secret = var.cloudfront_refer_secret
}
