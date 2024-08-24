resource "aws_iam_role" "codedeploy_deployment" {
  name               = "codedeploy-deployment"
  path               = "/service-role/"
  assume_role_policy = data.aws_iam_policy_document.codedeploy_deployment_assume_role_document.json
}

data "aws_iam_policy_document" "codedeploy_deployment_assume_role_document" {
  statement {
    effect = "Allow"
    principals {
      identifiers = [
        "codedeploy.amazonaws.com"
      ]
      type = "Service"
    }
    actions = [
      "sts:AssumeRole"
    ]
  }
}

resource "aws_iam_role_policy_attachment" "ecs_managed_policy_codedeploy_deployment" {
  role       = aws_iam_role.codedeploy_deployment.id
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeDeployRoleForECS"
}

output "codedeploy_deployment_arn" {
  value = aws_iam_role.codedeploy_deployment.arn
}
