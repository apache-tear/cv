terraform {
<<<<<<< HEAD
  required_version = ">= 1.2.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.28.0"
    }
  }

  cloud {
    organization = "rocknrolldevs"
=======
    cloud {
        organization = "ashdev"

>>>>>>> d29a8c3... TF initiated
    workspaces {
      name = "cv"
    }
  }
<<<<<<< HEAD
}

provider "aws" {
  region                   = "us-east-1"
  shared_config_files      = ["~/.aws/config"]
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "default"
=======
    
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
>>>>>>> d29a8c3... TF initiated
}