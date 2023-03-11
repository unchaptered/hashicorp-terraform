
data "aws_availability_zones" "my_zones" {

    filter {
      name  = "opt-in-status"
      values = [ "opt-in-not-required" ]
    }

}

data "aws_ec2_instance_type_offerings" "my_types" {

    location_type = "availability-zone"
    for_each = toset(data.aws_availability_zones.my_zones.names)

    filter {
        name = "instance-type"
        values = [ var.instance_type ]
    }

    filter {
        name = "location"
        values = [each.key]
    }

}