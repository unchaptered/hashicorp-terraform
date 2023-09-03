resource "aws_iam_user" "lb" {
  name = var.username
  path = "/system"
}
