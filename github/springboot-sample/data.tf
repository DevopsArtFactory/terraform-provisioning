data "sops_file" "springboot_sample" {
  source_file = "secrets.sops.yaml"
}
