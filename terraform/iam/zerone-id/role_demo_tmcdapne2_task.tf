resource "aws_iam_role" "demo_tmcdapne2_task" {
  name               = "demo-tmcdapne2-task"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.demo_tmcdapne2_task_assume_role_document.json
}

data "aws_iam_policy_document" "demo_tmcdapne2_task_assume_role_document" {
  statement {
    effect = "Allow"
    principals {
      identifiers = [
        "ecs-tasks.amazonaws.com"
      ]
      type = "Service"
    }
    actions = [
      "sts:AssumeRole"
    ]
    condition {
      test     = "StringEquals"
      variable = "aws:SourceAccount"
      values = [
        "066346343248"
      ]
    }
    condition {
      test     = "ArnLike"
      variable = "aws:SourceArn"
      values = [
        "arn:aws:ecs:ap-northeast-2:066346343248:*"
      ]
    }
  }
}

output "demo_tmcdapne2_task_arn" {
  value = aws_iam_role.demo_tmcdapne2_task.arn
}
