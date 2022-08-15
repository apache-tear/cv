variable "bucket_name" {
  type = string
}

data "aws_s3_bucket" "cvbucket" {
  bucket = "${var.bucket_name}"
}

resource "aws_s3_bucket" "cvbucket" {
  bucket = "${var.bucket_name}"
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

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_policy" "cvbucket" {
  bucket = aws_s3_bucket.cvbucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource = [
          aws_s3_bucket.cvbucket.arn,
          "${aws_s3_bucket.cvbucket.arn}/*",
        ]
      },
    ]
  })
}