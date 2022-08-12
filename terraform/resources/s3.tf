resource "aws_s3_bucket" "cvbucket" {
  bucket = "cv-s3-bucket-container"
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