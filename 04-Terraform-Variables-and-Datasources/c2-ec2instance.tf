# Resource Block : EC2 Instance
resource "aws_instance" "ec2demo" {
    ami             =   "ami-030e520ec063f6467"   # Ubuntu 18.04
    instance_type   =   "t2.micro"

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