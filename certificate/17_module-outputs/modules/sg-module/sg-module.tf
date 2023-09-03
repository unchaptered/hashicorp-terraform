# ~/modules/sg-module/sg.tf
resource "aws_security_group" "ec2-sg" {
  name = "myec2-sg"
  ingress {
    description = "Allow Inbound from Secret Application"

    from_port   = 8433
    to_port     = 8433
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "sg_id" {
  value = aws_security_group.ec2-sg.arn
}
