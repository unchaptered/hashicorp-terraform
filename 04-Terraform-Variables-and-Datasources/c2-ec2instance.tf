# Resource Block : EC2 Instance
resource "aws_instance" "ec2demo" {

    ami             =   data.aws_ami.amzlinux2.id

    instance_type   =   var.instance_type
    key_name        =   var.instance_key_pair
    vpc_security_group_ids = [ 
      aws_security_group.vpc-ssh.id,
      aws_security_group.vpc-web.id      
    ]

    user_data = file("${path.module}/app1-install.sh")
    
    tags = {
      "Name" = "ec2demo"
      
      "resource-level": "vpc"
      "resource-region": "ap-northeast-2"

      "group-stage": "terraform-learn"
      "group-service": "terraform-learn"
      "group-purpose": "api-server"
      "group-position": "backend"

      "manager": "unchaptered"
    }

}