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

#Policy for GH Actions role to assume federated web-identity
data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = ["arn:aws:iam::267231704888:oidc-provider/token.actions.githubusercontent.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = ["repo:apache-tear/*:*"]
    }
  }
}


resource "aws_iam_role" "gh_role" {
  name               = "gh_role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy

  tags = {
    tag-key = "Terraform"
  }
}



/*
resource "aws_iam_user_policy_attachment" "attachment" {
  role = aws_iam_user.new_user.name
  policy_arn = aws_iam_policy.policy.arn
}

<<EOF
    {
      "Version": "2012-10-17",
      "Statement": [
          {
            "Effect": "Allow",
            "Principal": {
                "Federated": "arn:aws:iam::267231704888:oidc-provider/token.actions.githubusercontent.com"
            },
            "Action": "sts:AssumeRoleWithWebIdentity",
            "Condition": {
                "StringEquals": {
                    "token.actions.githubusercontent.com:aud": "sts.amazonaws.com"
                },
                "StringLike": {
                    "token.actions.githubusercontent.com:sub": "repo:apache-tear/*:*"
                }
            }
          }
      ]
    }
  EOF


inline_policy {
    policy = { 
      "Version": "2012-10-17",
      "Statement": [
          {
            "Sid": "PutPermission",
            "Effect": "Allow",
            "Action": ["s3:PutObject"],
            "Resource": "arn:aws:s3:::a-sh.ae"
          }
      ]
    }
  }
*/
