variable "domain" {
  type    = string
  default = "a-sh.ae"
}

#S3 bucket policy
data "aws_iam_policy_document" "s3_policy" {
  #Perms for CF to get objects
  statement {
    sid       = "AllowCloudFrontServicePrincipalReadOnly"
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.cvbucket.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = ["${aws_cloudfront_origin_access_identity.oai.iam_arn}"]
    }
  }

  #Perms for GH Actions to put files into the bucket
  statement {
    sid       = "AllowGHPutActions"
    actions   = ["s3:PutObject"]
    resources = ["${aws_s3_bucket.cvbucket.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = ["${aws_iam_role.gh_role.arn}"]
    }
  }
}

resource "aws_s3_bucket" "cvbucket" {
  bucket = var.domain
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