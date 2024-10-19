module "jenkins_client_id" {
  source = "../../_modules/aws_ssm_parameter"

  ssm_parameter_name = "jenkins_client_id"

  ssm_parameter_key_id = data.terraform_remote_state.kms.outputs.aws_kms_key_apne2_deployment_common_arn
  ssm_parameter_value  = local.encrypted_values.jenkins_client_id

}