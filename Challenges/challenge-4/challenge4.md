# Challenge4

1. create iam user under different AWS accounts
    ${data.aws_caller_identity.current.account_id}"
2. output list of usernames under AWS account
3. output total number of AWS users

[datasource-accountid](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity)
[Terraform-Functions](https://developer.hashicorp.com/terraform/language/functions)
[Create-iam-user](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user)
[fetch-information-iam-user](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_user)

[length-function](https://developer.hashicorp.com/terraform/language/functions/length)
 