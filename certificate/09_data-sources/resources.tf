data "aws_ami" "app_ami" {
  most_recent = true
  owners      = ["awazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

resource "aws_instance" "my_ec2" {
  ami           = data.aws_ami.app_ami.id
  instance_type = "t2.micro"
}
