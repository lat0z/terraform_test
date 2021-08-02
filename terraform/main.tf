#Specify the provider required for the test
provider "aws" {
  region = "us-east-2"
}

#setting up instance for the test, it is using Amazon linux 
resource "aws_instance" "first_stage" {
  ami="ami-0443305dabd4be2bc"
  instance_type = "t2.micro"
  tags = {
    Name  = "Flugel"
    Owner = "InfraTeam"
  }
}

resource "aws_s3_bucket" "first_stage" {
  bucket = "my-first-stage-bucket"
  acl = "private"
  tags = {
    Name = "Flugel"
    Owner = "InfraTeam"
  }
}
