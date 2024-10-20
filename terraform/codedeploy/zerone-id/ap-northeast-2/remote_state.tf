data "terraform_remote_state" "iam" {
  backend = "s3"
  # config  = merge(var.remote_state.iam.zerone-id)
  config = merge(var.remote_state.iam.zerone-id, {"assume_role" = {"role_arn" = var.assume_role_arn}})
}

# data "terraform_remote_state" "nginx_tmcdapne2" {
#   backend = "s3"
#   config  = merge(var.remote_state.ecs.nginx.tmcdapne2)
#   # config = merge(var.remote_state.ecs.nginx.tmcdapne2), {"assume_role" = {"role_arn" = var.assume_role_arn}})
# }

data "terraform_remote_state" "demo_tmcdapne2" {
  backend = "s3"
  # config  = merge(var.remote_state.ecs.demo.tmcdapne2)
  config = merge(var.remote_state.ecs.demo.tmcdapne2, {"assume_role" = {"role_arn" = var.assume_role_arn}})
}