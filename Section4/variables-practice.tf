provider "aws" {
  region     = "us-west-2"
  access_key = "my-access-key"
  secret_key = "my-secret-key"
}
#input a variable instead of hardcoding
resource "aws_instance" "myec2" {
  ami = "ami-082b5a644766e0e6f"
  instance_type = var.instancetype
}

