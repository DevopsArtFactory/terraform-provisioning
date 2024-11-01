locals {
}

resource "aws_eks_node_group" "eks_node_group" {
  for_each        = { for node_config in var.node_group_configurations : node_config.name => node_config }
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "${var.cluster_name}-ng-${each.key}"
  node_role_arn   = aws_iam_role.eks_node_group.arn
  subnet_ids      = var.private_subnets

  ami_type        = each.value.ami_type
  capacity_type   = each.value.spot_enabled ? "SPOT" : "ON_DEMAND"
  # disk_size       = each.value.disk_size
  instance_types  = each.value.node_instance_types
  release_version = each.value.release_version != null ? each.value.release_version : var.release_version

  launch_template {
    id      = aws_launch_template.eks_node_group[0].id
    version = aws_launch_template.eks_node_group[0].latest_version
  }
  tags = merge(var.tags, tomap({
    "Name"                                      = "${var.cluster_name}-ng-${each.key}",
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }))

  labels = merge(each.value.labels, tomap({
    capacity_type = lower(each.value.spot_enabled ? "SPOT" : "CPU_ON_DEMAND")
  }))

  scaling_config {
    desired_size = each.value.node_desired_size
    max_size     = each.value.node_max_size
    min_size     = each.value.node_min_size
  }

  update_config {
    max_unavailable = var.node_max_unavailable
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_node_AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.eks_node_AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.eks_node_AmazonEC2ContainerRegistryReadOnly,
    aws_eks_access_entry.access_entry,
    aws_eks_access_policy_association.access_policy_association
  ]
}

resource "aws_launch_template" "eks_node_group" {
  count = var.enabled_node_disk_gp3 ? 1 : 0

  name = "${var.cluster_name}-node-launch-template"
  block_device_mappings {
    device_name = var.node_device_name

    ebs {
      volume_size           = var.ebs_volume_size
      volume_type           = var.ebs_volume_type
      encrypted             = true
      kms_key_id            = data.aws_kms_alias.ebs.id
      iops                  = var.ebs_volume_iops
      throughput            = var.ebs_volume_throughput
      delete_on_termination = var.ebs_delete_on_termination
    }

  }

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "optional"
    http_put_response_hop_limit = 2
  }
}

data "aws_kms_alias" "ebs" {
  name = "alias/aws/ebs"
}
# IAM
resource "aws_iam_role" "eks_node_group" {
  name        = "eks-${var.cluster_name}-ng"
  description = "Allows EC2 instances to call AWS services on your behalf."

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "ec2.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_security_group" "eks_node_group" {
  name        = "eks-${var.cluster_name}-ng"
  description = "Security group for node group"
  vpc_id      = var.target_vpc

  tags = merge(var.tags, tomap({
    "Name"                                      = "eks-${var.cluster_name}-ng",
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }))
}


resource "aws_iam_role_policy_attachment" "eks_node_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_node_group.name
}

resource "aws_iam_role_policy_attachment" "eks_node_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_node_group.name
}

resource "aws_iam_role_policy_attachment" "eks_node_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_node_group.name
}

resource "aws_iam_role_policy_attachment" "eks_node_AmazonSSMManagedInstanceCore" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = aws_iam_role.eks_node_group.name
}

resource "aws_iam_role_policy_attachment" "eks_node_AmazonEBSCSIDriverPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
  role       = aws_iam_role.eks_node_group.name
}

## Instance profile for nodes to pull images, networking, SSM, etc
resource "aws_iam_instance_profile" "eks_node_group" {
  name = "eks-${var.cluster_name}-ng"
  role = aws_iam_role.eks_node_group.name
}
