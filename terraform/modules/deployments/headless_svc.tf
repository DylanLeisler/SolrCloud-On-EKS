resource "kubernetes_service" "headless_solr" {

  metadata {
    name = "solr-headless-service"
  }

  spec {
    selector = {
      # app = kubernetes_pod.example.metadata.0.labels.app
      k8s-app = "solr"
    }
    cluster_ip = "None"
    type       = "ClusterIP"
  }

}
