provider "aws" {
  region     = "us-west-2"
  access_key = "my-access-key"
  secret_key = "my-secret-key"
}
resource "aws_instance" "myec2" {
  ami = ami-04823729c75214919
  instance_type = lookup(var.instance_type,terraform.workspace) 
  }

variable "instance_type" {
    type = "map"
    default = {
        default = "t2.nano"
        dev = "t2.micro"
        prod = "t2.large"
    }
}