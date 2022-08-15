terraform {
  required_version = ">= 1.1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  cloud {
    organization = "rocknrolldevs"
    workspaces {
      name = "cv"
    }
  }
}

provider "aws" {
  region = "eu-west-3"
  shared_config_files      = ["~/.aws/config"]
  shared_credentials_files = ["~/.aws/credentials"]
  profile = "default"
}

module "s3" {
  source = "./modules/s3"
  bucket_name = "${var.bucket_name}"
}

module "ec2" {
  source = "./modules/ec2"
}

module "pk" {
  source = "./modules/pk"
}
