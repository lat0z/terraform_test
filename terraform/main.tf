terraform {
  required_version = ">= 1.0.3"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 3.52.0"
    }
  }
}

#Specify the provider required for the test
provider "aws" {
  region = "us-east-2"
}

#Data source used to remove the hard coded ami id and use the latest one automatically
data "aws_ami" "amazon" {
  most_recent = true 
  owners = ["amazon"]
  filter {
    name = "name"
    values = ["amzn2-ami-hvm-2.0.*-x86_64-gp2"]
  }
}

#Variable used to remove the explicit tags in each resource 
variable "general_tags"{
  type = map(string)
  default = {
    Name  = "Flugel"
    Owner = "InfraTeam"
  }
}

#setting up instance for the test, it is using Amazon linux 
resource "aws_instance" "first_stage" {
  ami = data.aws_ami.amazon.id
  instance_type = "t2.micro"
   tags = var.general_tags
}

resource "aws_s3_bucket" "first_stage" {
  bucket = "my-first-stage-bucket"
  acl = "private"
  tags = var.general_tags
}

#Setup outputs to be able to validate the tags from terratest
output "instance_tags" {
  value = aws_instance.first_stage.tags
}

output "bucket_tags" {
  value = aws_s3_bucket.first_stage.tags
}
