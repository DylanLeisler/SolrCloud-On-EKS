#terraform.modules.eks-cluster['cluster.tf']



resource "aws_eks_cluster" "eks-cluster" {
  name     = var.cluster-name
  role_arn = aws_iam_role.eks-cluster-role.arn
  vpc_config {
    subnet_ids = var.public_subnets
  }

  depends_on = [aws_iam_role.eks-cluster-role]
}
