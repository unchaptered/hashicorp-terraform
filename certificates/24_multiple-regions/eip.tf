resource "aws_eip" "myeip" {
  vpc = "true"
}

resource "aws_eip" "myeip1" {
  vpc      = "true"
  provider = "aws.second_provider"
}
