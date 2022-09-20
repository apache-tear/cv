output "gh_role_arn" {
  description = "GH Role ARN"
  value       = aws_iam_role.gh_role.arn
}

output "bucket_url" {
  value = aws_s3_bucket.cvbucket.id
}

output "region" {
  value = data.aws_region.current
}