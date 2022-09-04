#Setting up S3 bucket

variable "bucket_name" {
  type    = string
  default = "a-sh.ae"
}

resource "aws_s3_bucket" "cvbucket" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_versioning" "versioning_enabled" {
  bucket = aws_s3_bucket.cvbucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_website_configuration" "cvbucket" {
  bucket = aws_s3_bucket.cvbucket.id
  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket_acl" "b_acl" {
  bucket = aws_s3_bucket.cvbucket.id
  acl    = "public-read"
}

resource "aws_s3_bucket_policy" "cvbucket" {
  bucket = aws_s3_bucket.cvbucket.id
  policy = data.aws_iam_policy_document.s3_policy.json
}