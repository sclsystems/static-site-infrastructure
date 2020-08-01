variable "domain_name" {
  type = object({
    domain         = string
    hosted_zone_id = string
  })
}

variable "mirror_domains" {
  type = list(object({
    domain         = string
    hosted_zone_id = string
  }))
}

variable "project_name" {
  type = string
}

variable "git_repository" {
  type = string
}

variable "buildspec_location" {
  type = string
}

variable "cloudfront_refer_secret" {
  type = string
}

variable "aws_region" {
  type = string
}
