# resource "kubernetes_persistent_volume_claim" "ebs_pvc" {
#   metadata {
#     name = "ebs-pvc"
#   }

#   spec {
#     access_modes       = ["ReadWriteMany"]
#     storage_class_name = var.sc-name-ebs

#     resources {
#       requests = {
#         storage = "512M"
#       }
#     }
#   }
# }
