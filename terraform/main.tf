terraform {
    cloud {
        organization = "ashdev"

    workspaces {
      name = "cv"
    }
  }
    
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 4.0"
    }
  }
}

provider "aws" {
    profile = "default"
    region = "eu-west-3"
}

module "s3" {
    source = "./resources"       
}