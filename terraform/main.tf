terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.28.0"
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
  region                   = "us-east-1"
  shared_config_files      = ["~/.aws/config"]
  shared_credentials_files = ["~/.aws/credentials"]
}


data "terraform_remote_state" "domain" {
  backend = "remote"

  config = {
    organization = "rocknrolldevs"
    
    workspaces = {
      name = "domain"
    }
  }
}

data "aws_region" "current" {}