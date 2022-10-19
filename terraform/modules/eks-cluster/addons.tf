#terraform.modules.eks-cluster['addons.tf']

resource "aws_eks_addon" "vpc-cni" {
  cluster_name = aws_eks_cluster.eks-cluster.name
  addon_name   = "vpc-cni"
}

resource "aws_eks_addon" "kube-proxy" {
  cluster_name = aws_eks_cluster.eks-cluster.name
  addon_name   = "kube-proxy"
}

resource "aws_eks_addon" "aws-ebs-csi-driver" {
  cluster_name = aws_eks_cluster.eks-cluster.name
  addon_name   = "aws-ebs-csi-driver"
}

resource "aws_eks_addon" "coredns" {
  cluster_name      = aws_eks_cluster.eks-cluster.name
  addon_name        = "coredns"
  resolve_conflicts = "OVERWRITE"
  addon_version     = "v1.8.7-eksbuild.3"

  depends_on = [
    aws_eks_node_group.tf-deployments
  ]
}
