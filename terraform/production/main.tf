terraform {
  backend "s3" {
    bucket         = "sre-bootcamp-bucket-prod"
    key            = "global/s3/terraform.tfstate"
    region         = "us-east-1"
    profile = "sre-bootcamp"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws",
      version = "~> 3"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "sre-bootcamp"
}

variable "pass" {}
variable "username" {}
variable "image_tag" {
  default = "latest"
}

module "sre-bootcamp" {
  source    = "../modules/sre-bootcamp/"
  env       = "prod"
  password  = var.pass
  username  = var.username
  image_tag = var.image_tag
}