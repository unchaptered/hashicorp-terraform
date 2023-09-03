data "aws_availability_zones" "aws_az_all_list" {
  
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }

}

data "aws_ec2_instance_type_offerings" "aws_az_valid_list" {

    location_type = "availability-zone"
    for_each = toset(
        data.aws_availability_zones
            .aws_az_all_list
            .names
    ) 

    filter {
        name    = "instance-type"
        values  = [ var.aws_ec2_instance_type ]
    }

    filter {
        name    = "location"
        values  = [ each.key ] 
    }

}

output "aws_az_valid_list" {
    value = toset([
        for aws_az_name, aws_az_meta in data.aws_ec2_instance_type_offerings.aws_az_valid_list: 
            aws_az_name if length(aws_az_meta.instance_types) == 1
    ])
}