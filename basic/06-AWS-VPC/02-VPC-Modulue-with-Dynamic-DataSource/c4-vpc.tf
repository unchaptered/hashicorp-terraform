# <Module Block>
# Ref : https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest

module "vpc" {
    
    source  = "terraform-aws-modules/vpc/aws"

    name    = var.service_name
    cidr    = "10.0.0.0/16"

    azs = toset([
        for aws_az_name, aws_az_meta in data.aws_ec2_instance_type_offerings.aws_az_valid_list: 
            aws_az_name if length(aws_az_meta.instance_types) == 1
    ])

    private_subnets = ["10.0.8.0/21", "10.0.136.0/21"]
    public_subnets  = ["10.0.0.0/22", "10.0.128.0/22"]

    enable_nat_gateway = true
    enable_vpn_gateway = true

    tags = {
        Trafrom = "true"
        Environment = "dev"
    }
}