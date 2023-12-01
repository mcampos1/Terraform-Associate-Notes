resource "aws_instance" "myec2" {
  ami = ami-04823729c75214919
  instance_type = "t2.micro"
  }