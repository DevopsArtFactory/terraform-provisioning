resource "aws_s3_bucket" "tmcdapne2_vpcflow_log" {
  bucket = "tmcdapne2-vpcflow-log"
}
resource "aws_s3_bucket_ownership_controls" "tmcdapne2_vpcflow_log_ownership" {
  bucket = aws_s3_bucket.tmcdapne2_vpcflow_log.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}
resource "aws_s3_bucket_acl" "tmcdapne2_vpcflow_log_bucket_acl" {
  depends_on = [aws_s3_bucket_ownership_controls.tmcdapne2_vpcflow_log_ownership]
  bucket     = aws_s3_bucket.tmcdapne2_vpcflow_log.id
  acl        = "private"
}

resource "aws_s3_bucket_policy" "tmcdapne2_vpcflow_log_bucket_policy" {
  bucket = aws_s3_bucket.tmcdapne2_vpcflow_log.id
  policy = data.aws_iam_policy_document.tmcdapne2_vpcflow_log_bucket_policy_document.json
}

data "aws_iam_policy_document" "tmcdapne2_vpcflow_log_bucket_policy_document" {
  statement {
    sid = "AWSLogDeliveryWrite"
    principals {
      type = "Service"
      identifiers = [
        "delivery.logs.amazonaws.com"
      ]
    }
    actions = [
      "s3:PutObject"
    ]
    condition {
      test     = "ArnLike"
      variable = "aws:SourceArn"
      values   = ["arn:aws:logs:ap-northeast-2:${var.account_id.id}:*"]
    }
    condition {
      test     = "StringEquals"
      variable = "aws:SourceAccount"
      values   = [var.account_id.id]
    }
    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }
    resources = [
      "arn:aws:s3:::tmcdapne2-vpcflow-log/AWSLogs/${var.account_id.id}/*",
    ]
  }
  statement {
    sid = "AWSLogDeliveryAclCheck"
    principals {
      type = "Service"
      identifiers = [
        "delivery.logs.amazonaws.com"
      ]
    }
    actions = [
      "s3:GetBucketAcl"
    ]
    condition {
      test     = "ArnLike"
      variable = "aws:SourceArn"
      values   = ["arn:aws:logs:ap-northeast-2:${var.account_id.id}:*"]
    }
    condition {
      test     = "StringEquals"
      variable = "aws:SourceAccount"
      values   = [var.account_id.id]
    }
    resources = [
      "arn:aws:s3:::tmcdapne2-vpcflow-log",
    ]
  }
}