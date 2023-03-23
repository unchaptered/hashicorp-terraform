# Get latest AMI ID for Amazon Linux2 OS
data "aws_ami" "amzlinux2" {
  most_recent      = true
  owners           = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-gp2"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}


# CUSTOM!
data "aws_availability_zones" "aws_az_all_list" {
  
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }

}

# CUSTOM!
data "aws_ec2_instance_type_offerings" "aws_az_valid_list" {

    location_type = "availability-zone"
    for_each = toset(
        data.aws_availability_zones
            .aws_az_all_list
            .names
    ) 

    filter {
        name    = "instance-type"
        values  = [ var.instance_type ]
    }

    filter {
        name    = "location"
        values  = [ each.key ] 
    }

}
