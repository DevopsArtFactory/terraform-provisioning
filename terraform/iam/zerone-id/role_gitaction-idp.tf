resource "aws_iam_openid_connect_provider" "gitaction_idp" {
  url = "https://token.actions.githubusercontent.com"

  client_id_list = [
    "sts.amazonaws.com"
  ]

  thumbprint_list = ["ffffffffffffffffffffffffffffffffffffffff"]
}
