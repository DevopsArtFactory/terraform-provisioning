resource "github_actions_variable" "example" {
  repository       = "terraform-provisioning"
  variable_name    = "example_variable_name"
  value            = "example_variable_value"
}
