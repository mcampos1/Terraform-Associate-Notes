provider "aws" {
  region     = "us-east-1"
}

resource "aws_eip" "lb" {
  domain = "vpc"
  }

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  
  ingress {
    description      = "TLS from VPC"
    from_port        = "443"
    to_port          = "443"
    protocol         = "tcp"
    cidr_blocks      = [${aws_eip.myeip.public_ip}/32]
