# Resource Block

resource "aws_instance" "ec2demo" {
    
    ami             = data.aws_ami.amzlinux2.id
    instance_type   = var.instance_type
    user_data       = file("${path.module}/app1-install.sh")

    key_name        = var.instance_key_pair

    vpc_security_group_ids = [
        aws_security_group.vpc-ssh.id,
        aws_security_group.vpc-web.id
    ]
    for_each = toset(keys({
        for az, details in data.aws_ec2_instance_type_offerings.my_types:
            az => details.instance_types if length(details.instance_types) != 0
    }))
    availability_zone = each.key

    tags = {
      "Name" = "For-Each-Demo-${each.key}"
      
      "resource-level": "vpc"
      "resource-region": "ap-northeast-2"

      "group-stage": "terraform-learn"
      "group-service": "terraform-learn"
      "group-purpose": "api-server"
      "group-position": "backend"

      "manager": "unchaptered"
    }
    
}