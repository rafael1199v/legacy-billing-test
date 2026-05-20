terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket = "rafael-vargas-examen-cloud"
    key    = "estado/terraform.tfstate"
    region = "us-east-1" 
  }
}

provider "aws" {
  region = var.aws_region
}