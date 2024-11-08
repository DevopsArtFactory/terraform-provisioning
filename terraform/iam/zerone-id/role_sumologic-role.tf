resource "aws_iam_role" "sumologic_role" {
  name               = "sumologic-role"
  assume_role_policy = data.aws_iam_policy_document.sumologic_assume_role_policy.json
}

data "aws_iam_policy_document" "sumologic_assume_role_policy" {
  statement {
    sid     = "AllowAssumeRoleForSumologic"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.account_id.sumologic}:root"]
    }
    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"
      values = ["kr:0000000000000393"]
    }
  }
}

data "aws_iam_policy_document" "sumologic_s3_policy_document" {
  statement {
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:ListBucketVersions",
      "s3:ListBucket"
    ]
    resources = [
        "arn:aws:s3:::tmcdapne2-vpcflow-log",
        "arn:aws:s3:::tmcdapne2-vpcflow-log/*",
    ]
  }
}

resource "aws_iam_policy" "sumologic_s3_policy" {
  name        = "sumologic-s3-policy"
  description = "Policy for Sumo Logic to receive s3 bucket logs"
  policy      = data.aws_iam_policy_document.sumologic_s3_policy_document.json
}

resource "aws_iam_role_policy_attachment" "sumologic_s3_attachment" {
  policy_arn = aws_iam_policy.sumologic_s3_policy.arn
  role       = aws_iam_role.sumologic_role.name
}
