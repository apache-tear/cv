#1. Create hosted zone -> Get NS -> Configure domain (custom registrar)
#2. Request ACM SSL cert -> Validate DNS
#3. Create alias records in Route53

resource "aws_route53_zone" "zone" {
  name = var.bucket_name
}

resource "aws_acm_certificate" "cert" {
  domain_name               = var.bucket_name
  subject_alternative_names = ["*.${var.bucket_name}"]
  validation_method         = "DNS"

  tags = {
    Name = var.bucket_name
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "validation" {
  certificate_arn = aws_acm_certificate.cert.arn
}

resource "aws_route53_record" "name" {
  zone_id = aws_route53_zone.zone.zone_id
  name    = var.bucket_name
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.distribution.domain_name
    zone_id                = aws_cloudfront_distribution.distribution.hosted_zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "wwwname" {
  zone_id = aws_route53_zone.zone.zone_id
  name    = "www.${var.bucket_name}"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.distribution.domain_name
    zone_id                = aws_cloudfront_distribution.distribution.hosted_zone_id
    evaluate_target_health = true
  }
}