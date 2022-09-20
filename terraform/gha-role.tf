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
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json

  tags = {
    tag-key = "Terraform"
  }
}

