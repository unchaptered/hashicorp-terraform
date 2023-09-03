module "ec2_cluster" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 2.0"

  name           = "my-cluster"
  instance_count = 1

  ami           = "ami-ebd02392"
  instance_type = lookup(var.instance_type_2, "terraform.workspace", "t2.nano")

  key_name   = "user1"
  monitoring = true

  vpc_security_group_ids = ["sg-12345678"]

  subnet_id = "subnet-eddcdzz4"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

variable "instance_type_2" {
  default = {
    default    = "t2.nano"
    cert-dev   = "t2.nano"
    cert-stage = "t2.micro"
    cert-prod  = "t2.large"
  }
}
