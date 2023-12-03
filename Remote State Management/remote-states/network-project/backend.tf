terraform {
    backend "s3"{
        bucket = "bucket-name"
        key = "network/eip.tfstate"
        region = "us-east-1" 
    }
}