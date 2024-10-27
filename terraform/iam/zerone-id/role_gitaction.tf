resource "aws_iam_role" "gitaction" {
  name               = "gitaction"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.gitaction_assume_role_document.json
}

data "aws_iam_policy_document" "gitaction_assume_role_document" {
  statement {
    effect = "Allow"

    principals {
      type = "Federated"
      identifiers = [
        "arn:aws:iam::${var.account_id.id}:oidc-provider/token.actions.githubusercontent.com"
      ]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values = [
        "sts.amazonaws.com"
      ]
    }

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values = [
        "repo:DevopsArtFactory/springboot-sample:*",
      ]
    }

    actions = ["sts:AssumeRoleWithWebIdentity", ]
  }
}

resource "aws_iam_role_policy" "gitaction_ecr" {
  name   = "gitaction-ecr"
  role   = aws_iam_role.gitaction.id
  policy = data.aws_iam_policy_document.gitaction_ecr.json

}

data "aws_iam_policy_document" "gitaction_ecr" {
  statement {
    sid       = "AllowGetAuthTokenAccess"
    effect    = "Allow"
    actions   = ["ecr:GetAuthorizationToken"]
    resources = ["*"]
  }

  statement {
    sid    = "AllowReadECRAccess"
    effect = "Allow"
    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:PutImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "gitaction_s3" {
  name   = "gitaction-s3"
  role   = aws_iam_role.gitaction.id
  policy = data.aws_iam_policy_document.gitaction_s3.json

}

data "aws_iam_policy_document" "gitaction_s3" {
  statement {
    sid       = "AllowAccessS3Bucket"
    effect    = "Allow"
    actions   = ["s3:PutObject"]
    resources = ["*"]
  }
}

# resource "aws_iam_role_policy" "gitaction_ecs" {
#   name   = "gitaction-ecs"
#   role   = aws_iam_role.gitaction.id
#   policy = data.aws_iam_policy_document.gitaction_ecs.json

# }

# data "aws_iam_policy_document" "gitaction_ecs" {
#   statement {
#     sid    = "RegisterTaskDefinition"
#     effect = "Allow"
#     actions = [
#       "ecs:RegisterTaskDefinition",
#       "ecs:DescribeTaskDefinition"
#     ]
#     resources = ["*"]
#   }

#   statement {
#     sid    = "PassRolesInTaskDefinition"
#     effect = "Allow"
#     actions = [
#       "iam:PassRole"
#     ]
#     resources = [
#       aws_iam_role.demo_tmcdapne2_task.arn,
#       aws_iam_role.demo_tmcdapne2_task_exec.arn
#     ]
#   }
#   statement {
#     sid    = "DeployService"
#     effect = "Allow"
#     actions = [
#       "ecs:DescribeServices",
#       "codedeploy:GetDeploymentGroup",
#       "codedeploy:CreateDeployment",
#       "codedeploy:GetDeployment",
#       "codedeploy:GetDeploymentConfig",
#       "codedeploy:RegisterApplicationRevision"
#     ]
#     resources = [
#       data.terraform_remote_state.demo_tmcdapne2.outputs.ecs_service_arn,
#       data.terraform_remote_state.codedeploy.outputs.demo_app_codedeploy_app_arn,
#       data.terraform_remote_state.codedeploy.outputs.demo_app_codedeploy_deployment_group_arn,
#       data.terraform_remote_state.codedeploy.outputs.demo_app_codedeploy_deployment_config_arn
#     ]
#   }
# }

output "gitaction_arn" {
  value = aws_iam_role.gitaction.arn
}
