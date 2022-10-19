#terraform.modules.eks-cluster['logs.tf']

resource "aws_cloudwatch_log_group" "eks-log-group" {
  # The log group name format is /aws/eks/<cluster-name>
  # Reference: https://docs.aws.amazon.com/eks/latest/userguide/control-plane-logs.html
  name              = "/aws/eks/${aws_eks_cluster.eks-cluster.name}"
  retention_in_days = 7
}
