provider "aws" {
  profile = "edint-prac"
}

resource "aws_iam_user" "demouser" {
    name = "kevin_demo_user"
}