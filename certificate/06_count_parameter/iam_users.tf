resource "aws_iam_user" "lb" {
  name = "loadbalancer"
  path = "/system"

  count = 5
}

resource "aws_iam_user" "lb2" {
  name = "loadbalancer${count.index}"
  path = "/system"

  count = 3
}

resource "aws_iam_user" "lb3" {
  name = var.iam_usernames[count.index]
  path = "/system"

  count = 3
}
