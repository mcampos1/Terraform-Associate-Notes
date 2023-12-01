provider "aws" {
  region     = "us-west-2"
  access_key = "my-access-key"
  secret_key = "my-secret-key"
}

locals {
    common_tags = {
        Owner = "DevOps Team"
        service = "backend"
    }
}

resource "aws_instance" "myec2" {
  ami = ami-04823729c75214919
  instance_type = "t2.micro"

  tags = local.common_tags
  #adds tags specified in the local values
  }
