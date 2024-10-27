locals {
  encrypted_values = data.sops_file.secret_values.data

  jenkins_envirement_variables = [
    {
      env_name  = "SERVICE_NAME",
      env_value = "JENKINS"
    },
    {
      env_name  = "VPC_NAME",
      env_value = "vpc-tmcd_apnortheast2"
    },
    {
      env_name  = "TARGET_GROUP_NAME",
      env_value = "jenkins-tmcdapne2-ext"
    },
    {
      env_name  = "SECURITY_GROUP_NAME",
      env_value = "jenkins-tmcd_apnortheast2"
    },
    {
      env_name  = "EFS_NAME",
      env_value = "jenkins-efs-tmcd_apnortheast2"
    },
    {
      env_name  = "ORG_NAME",
      env_value = "zerone-devops"
    },
    {
      env_name  = "TEAM_NAME",
      env_value = "admin"
    },
  ]
  demo_envirement_variables = [
    {
      env_name  = "SERVICE_NAME",
      env_value = "demoapp"
    },
    {
      env_name  = "VPC_NAME",
      env_value = "vpc-tmcd_apnortheast2"
    },
    {
      env_name  = "TARGET_GROUP_NAME",
      env_value = "demoapp-tmcdapne2-ext"
    },
    {
      env_name  = "SECURITY_GROUP_NAME",
      env_value = "demoapp-tmcd_apnortheast2"
    },
  ]
}