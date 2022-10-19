resource "kubernetes_stateful_set" "solr" {
  metadata {
    # annotations = {
    #   SomeAnnotation = "foobar"
    # }

    labels = {
      k8s-app = "solr"
      # "kubernetes.io/cluster-service"   = "true"
      # "addonmanager.kubernetes.io/mode" = "Reconcile"
    }

    name = "solr-set"
  }

  spec {
    pod_management_policy  = "Parallel"
    replicas               = 1
    revision_history_limit = 5

    selector {
      match_labels = {
        k8s-app = "solr"
      }
    }

    service_name = "solr"

    template {
      metadata {
        labels = {
          k8s-app = "solr"
        }

        annotations = {}
      }

      spec {
        # service_account_name = "prometheus"

        # init_container {
        #   name              = "init-chown-data"
        #   image             = "busybox:latest"
        #   image_pull_policy = "IfNotPresent"
        #   command           = ["chown", "-R", "65534:65534", "/data"]

        #   volume_mount {
        #     name       = "prometheus-data"
        #     mount_path = "/data"
        #     sub_path   = ""
        #   }
        # }

        container {
          name              = "my-solr"
          image             = "solr"
          image_pull_policy = "IfNotPresent"

          # args = [
          #   "--volume-dir=/etc/config",
          #   "--webhook-url=http://localhost:9090/-/reload",
          # ]

          port {
            container_port = 8983
          }

          volume_mount {
            name       = "ebs-pvc"
            mount_path = "/data"
            read_only  = false
          }

          #   readiness_probe {
          #     http_get {
          #       path = "/-/ready"
          #       port = 9090
          #     }

          #     initial_delay_seconds = 30
          #     timeout_seconds       = 30
          #   }

          #   liveness_probe {
          #     http_get {
          #       path   = "/-/healthy"
          #       port   = 9090
          #       scheme = "HTTPS"
          #     }

          #     initial_delay_seconds = 30
          #     timeout_seconds       = 30
          #   }
          # }

          # resources {
          #   limits = {
          #     cpu    = "10m"
          #     memory = "10Mi"
          #   }

          #   requests = {
          #     cpu    = "10m"
          #     memory = "10Mi"
          #   }
        } #container

        # volume {
        #   name = "ebs-volume"
        #   persistent_volume_claim {
        #     claim_name = "ebs_pvc"

        #   }

      }
    } #template
    volume_claim_template {
      metadata {
        name = "ebs-pvc"
      }

      spec {
        access_modes       = ["ReadWriteOnce"]
        storage_class_name = var.sc-name-ebs

        resources {
          requests = {
            storage = "1G"
          }
        }
      }
    } #volume claim temp.
  }   #spec
}     #resource
