module "sops_zerone_id" {
  source                  = "../_modules/sops"
  name = "zerond-id"
  allowed_arns_for_common = [ 
    "arn:aws:iam::${var.account_id.id}:root"
   ]
  allowed_arns_for_secure = [ 
    "arn:aws:iam::${var.account_id.id}:root"
   ]
}

output "sops_zerone_id_common_role_arn" {
  value = module.sops_zerone_id.common_role_arn
}

output "sops_zerone_id_secure_role_arn" {
  value = module.sops_zerone_id.secure_role_arn
}