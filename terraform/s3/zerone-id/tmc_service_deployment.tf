resource "aws_s3_bucket" "tmc-sample_deployment" {
  bucket = "tmc-service-deployment"
}

resource "aws_s3_bucket_accelerate_configuration" "tmc-sample_deploymentaccelerate_configuration" {
  bucket = aws_s3_bucket.tmc-sample_deployment.id
  status = "Enabled"
}

resource "aws_s3_bucket_policy" "tmc-sample_deploymentbucket_policy" {
  bucket = aws_s3_bucket.tmc-sample_deployment.id
  policy = data.aws_iam_policy_document.tmc-sample_deploymentbucket_policy_document.json
}

data "aws_iam_policy_document" "tmc-sample_deploymentbucket_policy_document" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["${var.account_id.id}"]
    }

    actions = [
      "s3:ListBucket",
      "s3:GetBucketLocation"
    ]

    resources = [
      aws_s3_bucket.tmc-sample_deployment.arn,
    ]
  }

  statement {
    principals {
      type        = "AWS"
      identifiers = ["${var.account_id.id}"]
    }

    actions = [
      "s3:GetObject"
    ]

    resources = [
      "${aws_s3_bucket.tmc-sample_deployment.arn}/*",
    ]
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "tmc-sample_deployment_lifecycle_configuration" {
  bucket = aws_s3_bucket.tmc-sample_deployment.id

  rule {
    id     = "intelligent-tiering"
    status = "Enabled"

    transition {
      days          = 3
      storage_class = "INTELLIGENT_TIERING"
    }
  }
}
