resource "kubernetes_storage_class" "ebs_standard" {
  metadata {
    name = var.sc-name-ebs
  }

  storage_provisioner = "kubernetes.io/aws-ebs"
  reclaim_policy      = "Delete"

  parameters = {
    fsType = "ext4"
    type   = "gp2"
  }
}
