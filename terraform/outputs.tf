/*output "ns_servers" {
  description = "NS servers"
  value       = aws_route53_zone.zone.name_servers
}

output "validation_record_name" {
  description = "Record name"
  value       = tolist(aws_acm_certificate.cert.domain_validation_options)[0].resource_record_name
}

output "validation_record_type" {
  description = "Record type"
  value       = tolist(aws_acm_certificate.cert.domain_validation_options)[0].resource_record_type
}

output "validation_record_value" {
  description = "Record value"
  value       = tolist(aws_acm_certificate.cert.domain_validation_options)[0].resource_record_value
}

output "cert_arn" {
  description = "Cert ARN"
  value       = aws_acm_certificate.cert.arn
}*/

output "cf_distribution_arn" {
  description = "CF Distribution ARN"
  value       = aws_cloudfront_distribution.distribution.arn
}

output "gh_role_arn" {
  description = "GH Role ARN"
  value       = aws_iam_role.gh_role.arn
}

output "bucket_url" {
  value = aws_s3_bucket.cvbucket.id
}