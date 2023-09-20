variable "usernumber" {}

variable "vpn_ip" {
  default = "116.50.30.20/32"
} 
#environment variables
variable "instancetype" {
   default = "t2.micro"
}

#running terraform plan with no default value will prompt you to input the value for that variable.
variable "instancetype" {}
