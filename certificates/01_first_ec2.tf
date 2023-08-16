provider "aws" {
  profile = "PROFILE_NAME"
}

resource "aws_instance" "my_ec2" {
    ami = "ami-0c9c942bd7bf113a2"
    instance_type = "t2.micro"

    tags = {
      "Name" = "terraform_ec2_test"
    }
}