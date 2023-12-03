data "terraform_remote_state" "eip" {
    backend = "s3"

    config = {
        bucket = "bucket-name"
        key = "netowkr/eip.tfstate"
        region = "us-east-1"
    }
}