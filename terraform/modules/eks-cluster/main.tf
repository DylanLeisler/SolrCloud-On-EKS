#eks.main.tf

resource "aws_eks_cluster" "eks-cluster" {
  name     = var.cluster-name
  role_arn = aws_iam_role.eks-cluster-role.arn
  vpc_config {
    subnet_ids = concat(
      values(var.private-subnet-ids),
    var.public-subnet-ids)
  }

  depends_on = [aws_iam_role.eks-cluster-role]
}

resource "aws_eks_addon" "vpc-cni" {
  cluster_name = aws_eks_cluster.eks-cluster.name
  addon_name   = "vpc-cni"
}

resource "aws_eks_addon" "kube-proxy" {
  cluster_name = aws_eks_cluster.eks-cluster.name
  addon_name   = "kube-proxy"
}

resource "aws_eks_addon" "coredns" {
  cluster_name      = aws_eks_cluster.eks-cluster.name
  addon_name        = "coredns"
  resolve_conflicts = "OVERWRITE"
}

resource "aws_cloudwatch_log_group" "eks-log-group" {
  # The log group name format is /aws/eks/<cluster-name>
  # Reference: https://docs.aws.amazon.com/eks/latest/userguide/control-plane-logs.html
  name              = "/aws/eks/${aws_eks_cluster.eks-cluster.name}"
  retention_in_days = 7
}

/* TYPE   SIZE  :  MAX NUM. PODS per INSTANCE (without manually configuring IP addresses)
  t2.xlarge and 2xlarge: 44 / t3: 58
  t2/t3.large: 35
  t2/t3.medium: 17
  t2/t3.small: 11
  t2/t3.micro: 4
  t2/t3.nano: 4
*/

resource "aws_eks_node_group" "managed_node_group" {
  for_each        = var.private-subnet-ids
  cluster_name    = aws_eks_cluster.eks-cluster.name
  node_group_name = "managed-node-group-${each.key}"
  node_role_arn   = aws_iam_role.node_group_role.arn
  subnet_ids      = [each.value]
  capacity_type   = "ON_DEMAND"
  instance_types  = ["t2.small"]
  labels = {
    microservice = each.key
  }
  taint {
    key    = "microservice"
    value  = each.key
    effect = "NO_SCHEDULE"
  }

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  # update_config {
  #   max_unavailable = 2
  # }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.

  depends_on = [
    aws_iam_role_policy_attachment.node-group-role-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node-group-role-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node-group-role-AmazonEC2ContainerRegistryReadOnly,
  ]
}

resource "aws_eks_node_group" "managed_node_group_addons" {
  cluster_name    = aws_eks_cluster.eks-cluster.name
  node_group_name = "managed-node-group-addons"
  node_role_arn   = aws_iam_role.node_group_role.arn
  subnet_ids      = [var.private-subnet-ids["user"]]
  capacity_type   = "ON_DEMAND"
  instance_types  = ["t2.small"]

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.node-group-role-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node-group-role-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node-group-role-AmazonEC2ContainerRegistryReadOnly,
  ]
}
