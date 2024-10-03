#
# zerone-id administrator
#
# resource "aws_iam_role" "assume_zerone_id_admin" {
#   name                 = "assume-zerone-id-admin"
#   path                 = "/"
#   max_session_duration = "43200"
#   assume_role_policy   = data.aws_iam_policy_document.assume_zerone_id_admin_assume_role.json
# }

# data "aws_iam_policy_document" "assume_zerone_id_admin_assume_role" {
#   statement {
#     actions = ["sts:AssumeRole"]
#     effect  = "Allow"

#     principals {
#       type = "AWS"
#       identifiers = [
#         "arn:aws:iam::${var.account_id.id}:root",
#       ]
#     }
#   }
# }

# resource "aws_iam_role_policy" "assume_zerone_id_admin_passrole" {
#   name = "assume-zerone-id-admin-passrole"
#   role = aws_iam_role.assume_zerone_id_admin.id

#   policy = data.aws_iam_policy_document.assume_zerone_id_admin_pass_role.json
# }

# data "aws_iam_policy_document" "assume_zerone_id_admin_pass_role" {
#   statement {
#     actions = ["iam:PassRole"]
#     effect  = "Allow"

#     resources = ["*"]
#   }
# }

# resource "aws_iam_role_policy_attachment" "assume_zerone_id_admin" {
#   role       = aws_iam_role.assume_zerone_id_admin.id
#   policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
# }


