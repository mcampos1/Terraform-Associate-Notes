variable "vpn_ip" {
  default = "116.50.30.20/32"
} 
#environment variables
variable "instance_type" {
   default = "t2.micro"
}
#command line flag: terraform plan -var
#running terraform plan with no default value will prompt you to input the value for that variable.
variable "instance_type" {}
