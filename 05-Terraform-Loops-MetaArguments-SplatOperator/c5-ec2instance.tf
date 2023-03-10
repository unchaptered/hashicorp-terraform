# Resource Block : EC2 Instance
resource "aws_instance" "ec2demo" {

    ami             =   data.aws_ami.amzlinux2.id

    instance_type   =   var.instance_type_list[0]     # EC2 Instance Type
    # instance_type   =   var.instance_type_map["prod"] # EC2 Instance Type
    key_name        =   var.instance_key_pair
    vpc_security_group_ids = [ 
      aws_security_group.vpc-ssh.id,
      aws_security_group.vpc-web.id      
    ]

    user_data = file("${path.module}/app1-install.sh")
    
    count = 2                                     # Create 5 Instance
    tags = {
      "Name" = "ec2demo-${count.index}"
      
      "resource-level": "vpc"
      "resource-region": "ap-northeast-2"

      "group-stage": "terraform-learn"
      "group-service": "terraform-learn"
      "group-purpose": "api-server"
      "group-position": "backend"

      "manager": "unchaptered"
    }

}