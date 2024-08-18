data "terraform_remote_state" "kms" {
    backend = "s3"
    config = merge(var.remote_state.kms.zerone-id)
    # config = merge(var.remote_state.kms.zerone-id, {"assume_role" = {"role_arn" = var.assume_role_arn}})
}