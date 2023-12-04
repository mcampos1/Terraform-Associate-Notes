provider "aws" {
  region     = "us-west-2"
  access_key = "my-access-key"
  secret_key = "my-secret-key"
}

module "ec2cluster" {
    source = "terraform-aws-modules/ec2-instance/aws"
    version = "~> 2.0"
    name = "my-cluster"
    instance_count = 1
    ami = "ami-1341324"
    instance_type = "t2.micro"
    subnet_id = "ami-141253534"
    tags = {
        Terraform = "true"
        Environment = "dev"
    }
}