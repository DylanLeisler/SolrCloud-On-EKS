#terraform.modules.eks-cluster['test-m-node.tf']


resource "aws_eks_node_group" "tf-deployments" {
  cluster_name    = aws_eks_cluster.eks-cluster.name
  node_group_name = "ng-managed-tf-deployments"
  node_role_arn   = aws_iam_role.node_group_role.arn
  subnet_ids      = [var.public_subnets[0]]
  capacity_type   = "ON_DEMAND"
  instance_types  = ["t2.small"]
  # labels = {
  #   microservice = each.key
  # }
  # taint {
  #   key    = "microservice"
  #   value  = each.key
  #   effect = "NO_SCHEDULE"
  # }

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 0
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
