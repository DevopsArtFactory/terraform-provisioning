module "codebuild_github_token" {
  source       = "../../_modules/codebuild/source_credential"
  github_token = local.encrypted_values.github_token
}