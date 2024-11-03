resource "aws_iam_role" "app_demoapp" {
  name = "app-demoapp"
  path = "/"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "ec2.amazonaws.com"
        },
        "Action" : "sts:AssumeRole",
      }
    ]
  })
}

resource "aws_iam_role_policy" "demoapp_operation" {
  name = "minimum-demoapp-operation-access"
  role = aws_iam_role.app_demoapp.id
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "AllowToDecryptKMSKey",
        "Action" : [
          "kms:Decrypt"
        ],
        "Resource" : [
          data.terraform_remote_state.kms.outputs.aws_kms_key_apne2_deployment_common_arn
        ],
        "Effect" : "Allow"
      },
      {
        "Effect" : "Allow",
        "Action" : "secretsmanager:GetSecretValue",
        "Resource" : [
          data.terraform_remote_state.secretsmanager.outputs.aws_secretsmanager_demo_tmcdapne2_id
        ]
      }
    ]
  })
}

resource "aws_iam_instance_profile" "app_demoapp" {
  name = "demoapp-profile"
  role = aws_iam_role.app_demoapp.name
}

resource "aws_iam_role_policy_attachment" "demoapp_attach" {
  role       = aws_iam_role.app_demoapp.name
  policy_arn = aws_iam_policy.app_universal.arn
}

output "app_demoapp_instance_profile" {
  value = aws_iam_instance_profile.app_demoapp.arn
}
