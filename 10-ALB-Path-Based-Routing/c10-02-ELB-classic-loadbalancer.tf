# Terrafrom AWS ELB(Elastic Load Balancer) as ALB(Application Load Balancer)

module "alb" {

    source    = "terraform-aws-modules/alb/aws"
    version   = "8.5.0"

    name      = "${local.name}-alb"
    vpc_id    = module.vpc.vpc_id

    load_balancer_type    = "application"

    subnets = [
        module.vpc.public_subnets[0],
        module.vpc.public_subnets[1]
    ]

    security_groups = [
        module.loadbalancer_sg.this_security_group_id
    ]
    
    # Listeners
    http_tcp_listeners = [
        {
        port               = 80
        protocol           = "HTTP"
        target_group_index = 0
        }
    ]

    # Target Groups
    target_groups = [
        # App1 Target Group - TG Index = 0
        {
            name_prefix      = "aoo1-"
            backend_protocol = "HTTPS"
            backend_port     = 443
            target_type      = "instance"

            deregistration_delay    =  10

            health_check = {

                enabled             =   true
                interval            =   30
                path                =   "/app1/index.html"
                port                =   "traffic-port"
                healthy_threshold   =   3
                unhealthy_threshold =   3
                timeout             =   6
                protocol            =   "HTTP"
                matcher             =   "200-399"

            }

            protocol_version    =   "HTTP1"

            # App1 Target Grouop - Targets

            targets = {
                my_app1_vm1 = {
                    target_id   = module.ec2_private[0].id
                    port        = 80
                },
                my_app1_vm2 = {
                    target_id   = module.ec2_private[1].id
                    port        = 80
                }
            }

            tags = local.common_tags

        }
    ]

    tags = local.common_tags

}