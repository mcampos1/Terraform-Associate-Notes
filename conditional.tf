provider "aws" {
  region     = "us-west-2"
  access_key = "my-access-key"
  secret_key = "my-secret-key"
}

resource "aws_instance" "dev" {
  ami = ami-04823729c75214919
  instance_type = "t2.micro"
}

resource "aws_instance" "prod" {
  ami = ami-04823729c75214919
  instance_type = "t2.micro"
}
