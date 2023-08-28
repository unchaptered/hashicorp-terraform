resource "aws_instance" "myec2" {
  ami           = "ami-0c9c942bd7bf113a2"
  instance_type = "t2.micro"
}
