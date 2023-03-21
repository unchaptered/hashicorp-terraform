

module "private_bastion_sg" {

  source    = "terraform-aws-modules/security-group/aws"
  version   = "1.19.0"

  # 언더바(_)보다 하이픈(-)이 AWS Management Console에서 더 잘보입니다.
  name        = "private-bastion-sg"
  description = "Security Group with HTTP & SSH port open for entire VPC Block (IPv4 CIDR), egress port all world open"

  vpc_id      = module.vpc.vpc_id

  # Ingress Rule & CIDR Block
  ingress_rules       = ["ssh-tcp", "http-80-tcp"]
  ingress_cidr_blocks = [module.vpc.vpc_cidr_block]

  # Egress Rule - Ingress Rule
  egress_rules        = ["all-all"]
  tags                = local.common_tags
  
}
