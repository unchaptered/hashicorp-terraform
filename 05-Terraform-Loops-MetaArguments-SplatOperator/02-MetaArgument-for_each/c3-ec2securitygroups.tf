# Security Group -- SSH Traffic

resource "aws_security_group" "vpc-ssh" {

    name = "vpc-ssh"
    description = "Dev VPC SSH"

    ingress = [ {
      self = false
      prefix_list_ids = []
      security_groups = []
      description = "Allow Port 22"
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = [ "0.0.0.0/0" ]
      ipv6_cidr_blocks = [ "::/0" ]
    } ]

    egress {
      description = "Allow all ip and ports outbound"
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
      "Name" = "ec2demovpc-ssh"
      
      "resource-level": "vpc"
      "resource-region": "ap-northeast-2"

      "group-stage": "terraform-learn"
      "group-service": "terraform-learn"
      "group-purpose": "api-server"
      "group-position": "backend"

      "manager": "unchaptered"
    }

  
}

# Security Group -- HTTP Traffic

resource "aws_security_group" "vpc-web" {

    name = "vpc-web"
    description = "Dev VPC Web"

    ingress = [ {
      self = false
      prefix_list_ids = []
      security_groups = []
      description = "Allow Port 80"
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = [ "0.0.0.0/0" ]
      ipv6_cidr_blocks = [ "::/0" ]
    } ]
    # ingress = [ {
    #   description = "Allow Port 80"
    #   from_port = 80
    #   to_port = 80
    #   protocol = "tcp"
    #   cidr_blocks = ["0.0.0.0/0"]
    # }, {
    #   description = "Allow Port 443"
    #   from_port = 443
    #   to_port = 443
    #   protocol = "tcp"
    #   cidr_blocks = ["0.0.0.0/0"]
    # }]

    egress {
      description = "Allow all ip and ports outbound"
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
      "Name" = "ec2demovpc-web"
      
      "resource-level": "vpc"
      "resource-region": "ap-northeast-2"

      "group-stage": "terraform-learn"
      "group-service": "terraform-learn"
      "group-purpose": "api-server"
      "group-position": "backend"

      "manager": "unchaptered"
    }

  
}
