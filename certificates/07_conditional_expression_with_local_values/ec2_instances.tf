resource "aws_instance" "dev" {
  ami           = "ami-0c9c942bd7bf113a2"
  instance_type = "t2.micro"

  count = var.istest == true ? 1 : 0

  tags = local.common_tags
}

resource "aws_instance" "prod" {
  ami           = "ami-0c9c942bd7bf113a2"
  instance_type = "t2.large"

  count = var.istest == false ? 1 : 0

  tags = local.common_tags
}
