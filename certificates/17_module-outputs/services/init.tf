# ~/services/init.tf
module "sg_module" {
  source = "../modules/sg-module"
}

resource "aws_instance" "web" {
  ami           = ""
  instance_type = "t3.micro"

  vpc_security_group_ids = [module.sg_module.sg_id]
}
