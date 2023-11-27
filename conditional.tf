#condition ?(then) true_value :(else) false_value

provider "aws" {
  region     = "us-west-2"
  access_key = "my-access-key"
  secret_key = "my-secret-key"
}

variable "istest" {} 

resource "aws_instance" "dev" {
  ami = ami-04823729c75214919
  instance_type = "t2.micro"
  count = var.istest == true ? 1 : 0 
#if var.istest is true then count=1 else count=0 and no ec2 instance will be created from that specific block
  count = var.istest == true ? 3 : 0 #if true creates 3 instances from this block
}

resource "aws_instance" "prod" {
  ami = ami-04823729c75214919
  instance_type = "t2.micro"
  count = var.istest == false ? 1 : 0
#if var.istest is false then instance will be created from this specific block else no prod ec2-instance
}
