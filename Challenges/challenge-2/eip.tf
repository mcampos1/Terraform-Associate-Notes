resource "aws_eip" "example" {
   domain = "vpc"
   tags = {
    Name = "payment_app"
    Team = "Payments Team"
    Env = "Production"
  }
}