# data "terraform_remote_state" "kms" {
#   backend = "s3"
#   config  = merge(var.remote_state.kms.zerone-id.apne2)
#   # config = merge(var.remote_state.kms.zerone-id, {"assume_role" = {"role_arn" = var.assume_role_arn}})
# }

# data "terraform_remote_state" "demo_tmcdapne2" {
#   backend = "s3"
#   config  = merge(var.remote_state.ecs.demo.tmcdapne2)
#   # config = merge(var.remote_state.ecs.demo.tmcdapne2, {"assume_role" = {"role_arn" = var.assume_role_arn}})
# }


# data "terraform_remote_state" "codedeploy" {
#   backend = "s3"
#   config  = merge(var.remote_state.codedeploy.zerone-id.apne2)
#   # config = merge(var.remote_state.codedeploy.zerone-id.apne2, {"assume_role" = {"role_arn" = var.assume_role_arn}})
# }