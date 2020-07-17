//Service used to expose Atlantis
resource "kubernetes_service" "atlantis_endpoint" {
  metadata {
    name = "atlantis-endpoint-svc"
  }
  spec {
    selector = {
      app = "atlantis"
      release = "atlantis"
    }
    port {
      port        = 80
      target_port = 4141
    }
    type = "LoadBalancer"
  }
}