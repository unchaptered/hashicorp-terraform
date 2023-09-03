resource "aws_iam_user" "lb" {
    name = "iamuser.${count.index}"
    path = "/system/"

    count = 3
}

output "arns" {
    value = aws_iam_user.lb[*].arn
}
output "name" {
    value = aws_iam_user.lb[*].name
}

output "zipmap" {
    value = zipmap(
        aws_iam_user.lb[*].arn,
        aws_iam_user.lb[*].name
    )
}