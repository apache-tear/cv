resource "aws_cloudfront_origin_access_identity" "oai" {
  comment = "Terraform"
}

resource "aws_cloudfront_distribution" "distribution" {
  origin {
    domain_name = aws_s3_bucket.cvbucket.bucket_regional_domain_name
    origin_id   = var.domain

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.oai.cloudfront_access_identity_path
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "CF Distribution via Terraform"
  default_root_object = "index.html"

  logging_config {
    include_cookies = false
    bucket          = "${var.domain}.s3.amazonaws.com"
    prefix          = "logs"
  }

  aliases = ["${var.domain}", "www.${var.domain}"]

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = var.domain
    compress         = true

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 300
    max_ttl                = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = {
    Created = "Terraform"
  }

  viewer_certificate {
    acm_certificate_arn = data.terraform_remote_state.domain.outputs.cert.arn
    ssl_support_method  = "sni-only"
  }
}