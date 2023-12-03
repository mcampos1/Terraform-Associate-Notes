terraform {
    backend "s3"{
        bucket = "bucket-name"
        key = "network/terraform.tfstate"
        region = "us-east-1" 
        dynamodb_table = "name-of-table" #in order for S3 to support state locking
    }
}