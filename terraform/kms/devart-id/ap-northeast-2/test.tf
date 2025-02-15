resource "aws_kms_key" "test" {
  description         = "KMS key for common secrets in ${var.aws_region}."
  enable_key_rotation = true
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Id" : "test",
    "Statement" : [
      {
        "Sid" : "Enable IAM User Permissions",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : [
            "arn:aws:iam::${var.account_id.id}:root"
          ]
        },
        "Action" : "kms:*",
        "Resource" : "*"
      }
    ]
  })

}

resource "aws_kms_alias" "test_kms_alias" {
  name          = "alias/test1"
  target_key_id = aws_kms_key.test.key_id
}

