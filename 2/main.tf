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
  default_tags {
    tags = {
      owner = var.owner
    }
  }
}

data "aws_ami" "image" {
  most_recent = true
  filter {
    name = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-*-x86_64-gp2"]
  }
  owners = ["amazon"]
}

resource "aws_instance" "hw_ec2_instance" {
  ami = data.aws_ami.image.image_id
  instance_type = "t2.micro"
  user_data = <<EOF
#! /bin/bash
amazon-linux-extras install -y nginx
sleep 2
systemctl enable nginx
sleep 2
systemctl start nginx
EOF
  tags = {
    Name = "instance_with_nginx"
  }
  volume_tags = {
    owner = var.owner
  }
}

resource "aws_db_instance" "my_database" {
  allocated_storage    = 5
  engine               = "mysql"
  engine_version       = "8.0.27"
  instance_class       = "db.t2.micro"
  identifier           = "hw_db"
  name                 = "my_database"
  username             = var.user
  password             = var.password
  skip_final_snapshot  = true
  backup_retention_period = 0
}
