variable "s3_bucket" {}

variable "project_name" {
  type = string
}

variable "cloudfront_distribution_id" {
  type = string
}

variable "git_repository" {
  type = string
}

variable "domain_name" {
  type = object({
    domain         = string
    hosted_zone_id = string
  })
}

variable "buildspec_location" {
  type = string
}
