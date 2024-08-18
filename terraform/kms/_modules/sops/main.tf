data "aws_region" "current" {}

resource "aws_kms_key" "default" {
  description         = "KMS key for encrypt with sops the ${replace(replace(var.alias, "-", " "), "_", " ")} secrets in ${data.aws_region.current.name}."
  enable_key_rotation = true
  policy = jsonencode({
    Version : "2012-10-17"
    Id : "key-default-1"
    Statement : [
      {
        "Sid" : "Enable IAM User Permissions",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : [for id in var.allowed_account_ids : "arn:aws:iam::${id}:root"]
        },
        "Action" : "kms:*",
        "Resource" : "*"
      },
      {
        "Sid" : "Enable IAM Application Permissions",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : var.allowed_role_arns
        },
        "Action" : [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:DescribeKey"
        ],
        "Resource" : "*"
      },
      {
        "Sid" : "Deny key deletion Permissions",
        "Effect" : "Deny",
        "Principal" : {
          "AWS" : "*"
        },
        "Action" : [
          "kms:Delete*",
          "kms:DisableKey",
          "kms:ScheduleKeyDeletion"
        ],
        "Resource" : "*",
        "Condition" : {
          "ArnNotEquals" : {
            "aws:SourceArn" : "arn:aws:iam::${var.account_id.dax-security}:root"
          }
        }
      }
    ]
  })
}

resource "aws_kms_alias" "default" {
  target_key_id = aws_kms_key.default.key_id
  name          = "alias/${var.alias}"
}

output "kms_key_arn" {
  value = aws_kms_key.default.arn
}
