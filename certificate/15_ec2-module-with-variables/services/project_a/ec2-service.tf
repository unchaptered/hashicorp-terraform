module "ec2_module" {
  source = "../../modules/ec2-module"

  instance_type = "t2.large"

  /*
    instance_type = "t2.largecertificates/14_ec2-module"

    This syntax occured this error.

    │ Error: Unsupported argument
    │
    │   on ec2-service.tf line 4, in module "ec2_module":
    │    4:   instance_type = "t2.largecertificates/14_ec2-module"
    │
    │ An argument named "instance_type" is not expected here.
  */
}
