# module.eks.output

output "id" {
  value = aws_eks_cluster.eks-cluster.id
}

output "cert" {
  value = aws_eks_cluster.eks-cluster.certificate_authority[0].data
}

output "endpoint" {
  value = aws_eks_cluster.eks-cluster.endpoint
}
