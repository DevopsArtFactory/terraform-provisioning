# #
# # zerone-id administrator
# #
# resource "aws_iam_role" "atlantis_zerone-id_admin" {
#   name = "atlantis-zerone-id-admin"
#   path = "/"

#   assume_role_policy = jsonencode({
#     "Version" : "2012-10-17",
#     "Statement" : [
#       {
#         "Sid" : "",
#         "Effect" : "Allow",
#         "Principal" : {
#           "AWS" : [
#             "arn:aws:iam::${var.account_id.id}:role/atlantis-ecs_task_execution"
#           ]
#         },
#         "Action" : "sts:AssumeRole"
#       }
#     ]
#   })

# }

# resource "aws_iam_role_policy" "atlantis_zerone-id_admin" {
#   name = "atlantis-zerone-id-admin-passrole"
#   role = aws_iam_role.atlantis_zerone-id_admin.id

#   policy = jsonencode({
#     "Statement" : [
#       {
#         "Sid" : "AllowIAMPassRole",
#         "Action" : [
#           "iam:PassRole"
#         ],
#         "Effect" : "Allow",
#         "Resource" : "*"
#       }
#     ]
#   })

# }

# resource "aws_iam_role_policy_attachment" "atlantis_zerone-id_admin" {
#   role       = aws_iam_role.atlantis_zerone-id_admin.id
#   policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
# }
