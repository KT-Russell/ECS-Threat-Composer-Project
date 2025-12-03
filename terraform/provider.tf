terraform {
  backend "s3" {
    bucket         = "ecstm-terraform-state"
    key            = "threat-mod/terraform.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "tm-terraform-lock"
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "eu-west-2"
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}



