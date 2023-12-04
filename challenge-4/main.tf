provider "aws" {
  region = "us-east-1"
}
data "aws_caller_identity" "current" {}
data "aws_iam_user" "users" {
  user_name = "an_example_user_name"
}
resource "aws_iam_user" "lb" {
  name = "admin-user-${data.aws_caller_identity.current.account_id}"
  path = "/system/"
}
#Outputs list of user names
output "user_names" { 
  value = data.aws_iam_user.users.names
}
#Output total number of users
output "total_users" {
  value = length(data.aws_iam_user.users.names)
}