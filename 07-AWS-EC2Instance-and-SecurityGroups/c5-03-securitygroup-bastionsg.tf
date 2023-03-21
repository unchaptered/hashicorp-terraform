

module "public_bastion_sg" {

  source    = "terraform-aws-modules/security-group/aws"
  version   = "1.19.0"

  # 언더바(_)보다 하이픈(-)이 AWS Management Console에서 더 잘보입니다.
  name        = "public-bastion-sg"
  description = "Security Group with SSH port open for everybody(IPv4 CIDR), egress port all world open"

  vpc_id      = module.vpc.vpc_id

  # Ingress Rule & CIDR Block
  ingress_rules       = ["ssh-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"]

  # Egress Rule - Ingress Rule
  egress_rules        = ["all-all"]
  tags                = local.common_tags
  
}
