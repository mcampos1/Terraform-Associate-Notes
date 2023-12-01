#Security Group gets created first
module "sgmodule" {
    source = "../../modules/sg" #integrates the newly created security group to the new ec2
}

resource "aws_instance" "myec2" {
    ami = ami-04823729c75214919
    instance_type = "t2.micro"
    vpc_security_group_ids = [module.sgmodule.sg_id] 
}