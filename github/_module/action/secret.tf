resource "github_actions_secret" "secret" {
  repository      = var.repository
  secret_name     = var.secret_name
  plaintext_value = var.secret_string
}
