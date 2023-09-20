variable "elb_name" {}

variable "az" {}

variable "timeout" {}

#only number values will be accepted for the variable
variable "usernumber" {
  type = number
}

#default value
variable "vpn_ip" {
  default = "116.50.30.20/32"
} 

#default value
variable "instancetype" {
   default = "t2.micro"
}

#running terraform plan with no default value will prompt you to input the value for that variable.
variable "instancetype" {}
