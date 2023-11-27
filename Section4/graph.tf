provider "aws" {
  region     = "us-west-2"
  access_key = "my-access-key"
  secret_key = "my-secret-key"
}

resource "aws_instance" "instance-1" {
  ami = data.aws_ami.app_ami.id
  instance_type = "t2.micro"
  }

resource "aws_eip" "lb" {
    instance = aws_instance.myec2.id
    vpc = true
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
  }
}

#terraform graph > graph.dot