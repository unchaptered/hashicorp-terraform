# <Module Block>
# Ref : https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest

module "vpc" {
    
    source  = "terraform-aws-modules/vpc/aws"

    name    = var.service_name
    cidr    = "10.0.0.0/16"

    azs             = ["ap-northeast-2a", "ap-northeast-2c"]
    private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
    public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

    enable_nat_gateway = true
    enable_vpn_gateway = true

    tags = {
        Trafrom = "true"
        Environment = "dev"
    }
}