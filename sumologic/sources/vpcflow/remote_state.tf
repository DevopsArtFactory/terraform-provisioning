data "terraform_remote_state" "sumologic_collector" {
  backend = "s3"

  config = merge(var.remote_state.collector, {"assume_role" = { "role_arn" = var.assume_role_arn }})
}
