data "aws_ami" "amzlinux2" {

    most_recent     = true
    name_regex      = "^myami-\\d{3}"
    owners          =  ["self"]

    filter {
        name    = "name"
        values  = ["myami-*"]
    }

    filter {
        name    = "root-device-type"
        values  = ["ebs"]
    }

    filter {
        name    = "virtualization-type"
        values  = ["hvm"]
    }
}