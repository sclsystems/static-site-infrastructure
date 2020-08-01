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

variable "domain_name_certificate_arn" {
  type = string
}

variable "cloudfront_refer_secret" {
  type = string
}
