resource "aws_iam_role" "codebuild_deployment" {
  name               = "codebuild-deployment"
  path               = "/service-role/"
  assume_role_policy = data.aws_iam_policy_document.codebuild_deployment_assume_role_document.json
}

data "aws_iam_policy_document" "codebuild_deployment_assume_role_document" {
  statement {
    effect = "Allow"
    principals {
      identifiers = [
        "codebuild.amazonaws.com"
      ]
      type = "Service"
    }
    actions = [
      "sts:AssumeRole"
    ]
  }
}

resource "aws_iam_role_policy" "codebuild_deployment_operation" {
  name   = "codebuild-deployment-operation-access"
  role   = aws_iam_role.codebuild_deployment.id
  policy = data.aws_iam_policy_document.codebuild_deployment_operation_document.json
}

data "aws_iam_policy_document" "codebuild_deployment_operation_document" {
  statement {
    sid    = "SSMSendCommand"
    effect = "Allow"
    resources = [
      "*"
    ]
    actions = [
      "ssm:SendCommand",
      "ssm:ListCommandInvocations"
    ]
  }

  statement {
    sid    = "CloudwatchAccess"
    effect = "Allow"
    resources = [
      "*"
    ]
    actions = [
      "cloudwatch:PutMetricAlarm",
      "cloudwatch:Get*"
    ]
  }

  statement {
    sid    = "DeploymentELBAccess"
    effect = "Allow"
    resources = [
      "*"
    ]
    actions = [
      "elasticloadbalancing:DescribeLoadBalancerAttributes",
      "elasticloadbalancing:DescribeLoadBalancers",
      "elasticloadbalancing:DescribeTargetGroupAttributes",
      "elasticloadbalancing:DescribeTargetHealth",
      "elasticloadbalancing:DescribeTargetGroups",
      "elasticloadbalancing:DescribeListeners",
      "elasticloadbalancing:DescribeTags",
      "elasticloadbalancing:DescribeRules",
      "elasticloadbalancing:DescribeInstanceHealth"
    ]
  }

  statement {
    sid    = "DeploymentIAMAccess"
    effect = "Allow"
    resources = [
      "*"
    ]
    actions = [
      "iam:PassRole"
    ]
  }

  statement {
    effect = "Allow"
    resources = [
      "arn:aws:ec2:ap-northeast-2:${var.account_id.id}:network-interface/*"
    ]
    actions = [
      "ec2:CreateNetworkInterfacePermission"
    ]
  }

  statement {
    sid    = "LaunchTemplates"
    effect = "Allow"
    resources = [
      "*"
    ]
    actions = [
      "ec2:DeleteLaunchTemplate",
      "ec2:CreateLaunchTemplate",
      "ec2:GetLaunchTemplateData",
      "ec2:DescribeLaunchTemplates",
      "ec2:DescribeLaunchTemplateVersions",
      "ec2:ModifyLaunchTemplate",
      "ec2:DeleteLaunchTemplateVersions",
      "ec2:CreateLaunchTemplateVersion"
    ]
  }

  statement {
    sid    = "DeploymentVPCAccess"
    effect = "Allow"
    resources = [
      "*"
    ]
    actions = [
      "ec2:CreateNetworkInterface",
      "ec2:DescribeDhcpOptions",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DeleteNetworkInterface",
      "ec2:DescribeSubnets",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeVpcs"
    ]
  }

  statement {
    sid    = "DeploymentASGAccess"
    effect = "Allow"
    resources = [
      "*"
    ]
    actions = [
      "autoscaling:*"
    ]
  }

  statement {
    sid    = "DeploymentVolumeAccess"
    effect = "Allow"
    resources = [
      "*"
    ]
    actions = [
      "ec2:AttachVolume",
      "ec2:CreateVolume",
      "ec2:DeleteVolume",
      "ec2:DescribeVolume*",
      "ec2:DetachVolume"
    ]
  }

  statement {
    sid    = "DeploymentKeyPairAccess"
    effect = "Allow"
    resources = [
      "*"
    ]
    actions = [
      "ec2:DescribeKeyPairs"
    ]
  }

  statement {
    sid    = "DeploymentInstanceAccess"
    effect = "Allow"
    resources = [
      "*"
    ]
    actions = [
      "ec2:RunInstances",
      "ec2:StartInstances",
      "ec2:StopInstances",
      "ec2:RebootInstances",
      "ec2:TerminateInstances",
      "ec2:DescribeInstances",
      "ec2:CreateTags",
      "ec2:DescribeTags",
      "ec2:ModifyInstanceAttribute"
    ]
  }

  statement {
    sid    = "DeploymentSnapshotAccess"
    effect = "Allow"
    resources = [
      "*"
    ]
    actions = [
      "ec2:CreateSnapshot",
      "ec2:DescribeSnapshots"
    ]
  }

  statement {
    sid    = "DeploymentAMIAccess"
    effect = "Allow"
    resources = [
      "*"
    ]
    actions = [
      "ec2:RegisterImage",
      "ec2:DescribeImages"
    ]
  }

  statement {
    sid    = "DeploymentSecurityGroupAccess"
    effect = "Allow"
    resources = [
      "*"
    ]
    actions = [
      "ec2:CreateSecurityGroup",
      "ec2:DescribeSecurityGroups",
      "ec2:AuthorizeSecurityGroupIngress",
      "ec2:RevokeSecurityGroupIngress"
    ]
  }
}

resource "aws_iam_role_policy" "codebuild_deployment_ecr" {
  name   = "codebuild-deployment-ecr"
  role   = aws_iam_role.codebuild_deployment.id
  policy = data.aws_iam_policy_document.codebuild_deployment_ecr_document.json
}

data "aws_iam_policy_document" "codebuild_deployment_ecr_document" {
  statement {
    sid    = "AllowReadECRAccess"
    effect = "Allow"
    resources = [
      "*"
    ]
    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:PutImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload"
    ]
  }

  statement {
    sid    = "AllowGetAuthTokenAccess"
    effect = "Allow"
    resources = [
      "*"
    ]
    actions = [
      "ecr:GetAuthorizationToken",
      "ecr-public:GetAuthorizationToken",
      "sts:GetServiceBearerToken"
    ]
  }
}

resource "aws_iam_role_policy" "codebuild_deployment_kms" {
  name   = "codebuild-deployment-kms-decryption"
  role   = aws_iam_role.codebuild_deployment.id
  policy = data.aws_iam_policy_document.codebuild_deployment_kms_ssm_document.json
}

data "aws_iam_policy_document" "codebuild_deployment_kms_ssm_document" {
  statement {
    sid    = "AllowToDecryptKMSKey"
    effect = "Allow"
    resources = [
      data.terraform_remote_state.kms.outputs.aws_kms_key_apne2_deployment_common_arn
    ]
    actions = [
      "kms:Decrypt"
    ]
  }

  statement {
    sid    = "AllowSsmParameterAccess"
    effect = "Allow"
    resources = [
      "arn:aws:ssm:ap-northeast-2:${var.account_id.id}:parameter/CodeBuild/*",
    ]
    actions = [
      "ssm:GetParameter",
      "ssm:GetParameters"
    ]
  }
}

resource "aws_iam_role_policy" "codebuild_deployment_cloudwatch" {
  name   = "codebuild-deployment-cloudwatch"
  role   = aws_iam_role.codebuild_deployment.id
  policy = data.aws_iam_policy_document.codebuild_deployment_cloudwatch_document.json
}

data "aws_iam_policy_document" "codebuild_deployment_cloudwatch_document" {
  statement {
    sid    = "AllowCloudWatchAccess"
    effect = "Allow"
    resources = [
      "arn:aws:logs:*:${var.account_id.id}:log-group:/aws/codebuild/*",
      "arn:aws:logs:*:${var.account_id.id}:log-group:/aws/codebuild/*:*",
      "arn:aws:logs:*:${var.account_id.id}:log-group:/*",
      "arn:aws:logs:*:${var.account_id.id}:log-group:/*:*",
      "arn:aws:logs:*:${var.account_id.id}:log-group:/*:*:*",
      "arn:aws:logs:*:${var.account_id.id}:log-group:*:*:*/*"
    ]
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
  }
}

resource "aws_iam_instance_profile" "codebuild_deployment" {
  name = "codebuild-deployment-profile"
  role = aws_iam_role.codebuild_deployment.name
}

output "codebuild_deployment_instance_profile" {
  value = aws_iam_instance_profile.codebuild_deployment.arn
}

output "codebuild_deployment_arn" {
  value = aws_iam_role.codebuild_deployment.arn
}
