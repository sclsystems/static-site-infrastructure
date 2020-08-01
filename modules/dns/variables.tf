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

variable "cloudfront_hosted_zone_id" {
  type = string
}

variable "cloudfront_domain_name" {
  type = string
}
