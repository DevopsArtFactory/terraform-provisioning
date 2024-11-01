locals {
  # Flatten out entries and policy associations so users can specify the policy
  # associations within a single entry
  flattened_access_entries = {
    for idx, entry in flatten([
      for entry_key, entry_val in var.access_entries : [
        for pol_key, pol_val in lookup(entry_val, "policy_associations", {}) :
        merge(
          {
            principal_arn = entry_val.principal_arn
            entry_key     = entry_key
            pol_key       = pol_key
          },
          {
            association_policy_arn              = pol_val.policy_arn
            association_access_scope_type       = pol_val.access_scope.type
            association_access_scope_namespaces = lookup(pol_val.access_scope, "namespaces", [])
          }
        )
      ]
    ]) :
    "${entry.entry_key}-${entry.pol_key}" => entry
  }
}

resource "aws_eks_access_entry" "access_entry" {
  for_each = var.access_entries
  cluster_name      = aws_eks_cluster.eks_cluster.name
  kubernetes_groups = try(each.value.kubernetes_groups, null)
  principal_arn     = each.value.principal_arn
  tags = merge(var.tags, try(each.value.tags, {}))
}

resource "aws_eks_access_policy_association" "access_policy_association" {
  for_each = local.flattened_access_entries
  access_scope {
    namespaces = try(each.value.association_access_scope_namespaces, [])
    type       = each.value.association_access_scope_type
  }
  cluster_name = aws_eks_cluster.eks_cluster.name
  policy_arn    = each.value.association_policy_arn
  principal_arn = each.value.principal_arn
  depends_on = [
    aws_eks_access_entry.access_entry,
  ]
}