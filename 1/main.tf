terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  required_version = "~> 1.0"
}

provider "aws" {
  region = "eu-central-1"
}

data "aws_vpcs" "show_vpcs" {}

data "aws_subnets" "show_subnets" {}

data "aws_security_groups" "show_sg" {
  filter {
    name = "vpc-id"
    values = [ "*" ]
  }
}
