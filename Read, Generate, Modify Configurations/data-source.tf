provider "aws" {
  region     = "us-west-2"
  access_key = "my-access-key"
  secret_key = "my-secret-key"
}
#pulls latest Amazon Linux 2 AMI for any region

data "aws_ami" "app_ami" {
    most_recent = true
    #specifies most recent ami from amazon
    owners = ["amazon"]

    filter {
        name = "name"
        #filters to amazon linux 2 ami
        values = ["amzn2-ami-hvm*"]
    }
}

resource "aws_instance" "instance-1" {
  ami = data.aws_ami.app_ami.id
  instance_type = "t2.micro"
  }