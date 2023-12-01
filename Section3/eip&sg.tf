provider "aws" {
  region     = "us-east-1"
}

resource "aws_eip" "lb" {
  domain = "vpc"
  }

#outputs the value of the attibute to the console after running Terraform apply
output "public-ip" {
  #value = aws_eip.lb.public_ip #outputs the public_ip attribute of that resource
  value = "https://${aws_eip.lb.public_ip}:8080" #outputs the FQDN
  value = aws_eip.lb #outputs all the attributes of that resource
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  
  ingress {
    description      = "TLS from VPC"
    from_port        = "443"
    to_port          = "443"
    protocol         = "tcp"
    cidr_blocks      = ["${aws_eip.myeip.public_ip}/32"]

#correct the format of the cidr_blocks to have a compatible format
