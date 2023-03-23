# AWS EC2 Instance Terraform Module
# Bastion Host - EC2 Instance that will be created in VPC Public Subnet.


# https://registry.terraform.io/modules/terraform-aws-modules/ec2-instance/aws/latest


module "ec2_private_app1" {

    depends_on = [ module.vpc ]

    source  = "terraform-aws-modules/ec2-instance/aws"
    version = "4.3.0"

    name            = "${var.environment}-app1"
    # instance_count  = 2

    ami                    = data.aws_ami.amzlinux2.id
    instance_type          = var.instance_type
    key_name               = var.instance_keypair

    # monitoring             = true
    count                   = var.private_instance_count
    subnet_id               = module.vpc.private_subnets[0]
    vpc_security_group_ids  = [module.private_sg.this_security_group_id]

    tags        = local.common_tags
    user_data   = file("${path.module}/app1-install.sh")

}