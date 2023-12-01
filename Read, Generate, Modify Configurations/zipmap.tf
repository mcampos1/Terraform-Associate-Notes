provider "aws" {
  region = "us-east-1"
}
resource "aws_iam_user" "lb" { #creates iam users starting from 0
  name = "iamuser.${count.index}"
  count = 3
  path = "/system"
}
output "arns" { #outputs list of iam user arns
  value = aws_iam_user.lb[*].arn
}
output "name" { #outputs list of iamuser names 
  value = aws_iam_user.lb[*].name
}
output "combined" { #creates zipmap from the 2 lists
  value = zipmap(aws_iam_user.lb[*].name,aws_iam_user.lb[*].arn)
}
