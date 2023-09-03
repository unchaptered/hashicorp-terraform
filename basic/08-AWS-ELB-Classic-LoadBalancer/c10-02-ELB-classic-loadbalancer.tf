# Terrafrom AWS ELB(Elastic Load Balancer) as CLB(Class Load Balancer)
module "elb" {

    source  = "terraform-aws-modules/elb/aws"
    version = "4.0.1"

    name    = "${local.name}-myelb"
    
    subnets         = [
        module.vpc.public_subnets[0],
        module.vpc.public_subnets[1]
    ]
    security_groups = [ module.loadbalancer_sg.this_security_group_id ]
    internal        = false

    listener = [
        {
            instance_port       = 80
            instance_protocol   = "HTTP"
            lb_port             = 80
            lb_protocol         = "HTTP"
        },
        {
            instance_port       = 80
            instance_protocol   = "HTTP"
            lb_port             = 81
            lb_protocol         = "HTTP"
            # ssl_certificate_id  = "TSL/SSL 인증서 ARN"
        }
    ]

    health_check = {
        target              = "HTTP:80/"
        interval            = 30
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = 5
    }

    number_of_instances     = var.private_instance_count
    instances               = module.ec2_private[*].id

    tags                    = local.common_tags

}