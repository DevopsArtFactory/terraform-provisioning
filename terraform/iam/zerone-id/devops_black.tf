############## DevOps Black Group ##################
resource "aws_iam_group" "devops_black" {
  name = "devops_black"
}

resource "aws_iam_group_membership" "devops_black" {
  name = aws_iam_group.devops_black.name

  users = [
    aws_iam_user.zerone.name,
  ]

  group = aws_iam_group.devops_black.name
}
########### Managed Policies ####################
resource "aws_iam_group_policy_attachment" "devops_black" {
  group      = aws_iam_group.devops_black.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
######################################################

############### Basic Policy ##################

######################################################

########### Assume Policies ####################
resource "aws_iam_group_policy" "assume_role_policy" {
  name   = "assume-role-policy"
  group  = aws_iam_group.devops_black.name
  policy = data.aws_iam_policy_document.assume_role_policy.json
}
data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    resources = ["arn:aws:iam::816736805842:role/assume-zerone-id-admin"]
  }
}
######################################################


