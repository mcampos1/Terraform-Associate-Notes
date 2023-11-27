provider "aws" {
  region     = "us-west-2"
  access_key = "my-access-key"
  secret_key = "my-secret-key"
}

resource "aws_iam_user" "lb" {
  name = "iamuser.${count.index} #0-2
  count = 3
  path = "/system"
}

output "arns" {
    value = aws_iam_user.lb[*].arn #returns list of attributes for all iam users 
}
  