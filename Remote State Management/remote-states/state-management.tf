provider "aws" {
  region     = "us-west-2"
  access_key = "my-access-key"
  secret_key = "my-secret-key"
}
resource "aws_instance" "myec2" {
  ami = ami-04823729c75214919
  instance_type = lookup(var.instance_type,terraform.workspace) 
}
resource "aws_iam_user" "lb" {
    name = "loadbalancer"
    path = "/system"
}

terraform {
    backend "s3"{
        bucket = "bucket-name"
        key = "demo.tfstate"
        region = "us-east-1" 
        access_key = "my-access-key"
        secret_key = "my-secret-key"
    }
}