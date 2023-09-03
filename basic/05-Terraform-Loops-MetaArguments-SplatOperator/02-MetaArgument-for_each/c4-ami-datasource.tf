# EC2 AMI 데이터 소스
data "aws_ami" "amzlinux2" {

    most_recent     = true
    owners          =  ["amazon"]

    filter {
        name    = "name"
        values  = ["amzn2-ami-hvm-*-gp2"]
    }

    filter {
        name    = "root-device-type"
        values  = ["ebs"]
    }

    filter {
        name    = "virtualization-type"
        values  = ["hvm"]
    }

    filter {
        name    = "architecture"
        values  = ["x86_64"]
    }
    
}

# VPC AZ 데이터 소스
data "aws_availability_zones" "my_zones" {

    filter {
      name  = "opt-in-status"
      values = ["opt-in-not-required"]
    }

}