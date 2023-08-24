variable "sg_ports" {
  type        = list(number)
  description = "list of ingress ports"
  default     = [8200, 8201, 8300, 9200, 9500]
}

resource "aws_security_group" "dynamic_security_group" {
  name        = "dynamic-sg"
  description = "Ingress for Vault"

  # Dynamic Blocks without Iterator
  dynamic "ingress" {
    for_each = var.sg_ports
    content {
      from_port = ingress.value
      to_port   = ingress.value

      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  # Dynamic Block with Iterator
  dynamic "egress" {
    for_each = var.sg_ports
    iterator = port
    content {
      from_port = port.value
      to_port   = port.value

      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}
