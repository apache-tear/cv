# Hosted zone data pulled from centralized domain control workspace.

locals {
  zone = data.terraform_remote_state.domain.outputs.zone
}

resource "aws_route53_record" "to_CF" {
  zone_id = local.zone.zone_id
  name    = var.domain
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.distribution.domain_name
    zone_id                = aws_cloudfront_distribution.distribution.hosted_zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "www_to_CF" {
  zone_id = local.zone.zone_id
  name    = "www.${var.domain}"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.distribution.domain_name
    zone_id                = aws_cloudfront_distribution.distribution.hosted_zone_id
    evaluate_target_health = true
  }
}