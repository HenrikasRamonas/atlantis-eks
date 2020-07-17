output atlantis_endpoint {
  description = "Atlantis endpoint"
  value = kubernetes_service.atlantis_endpoint.load_balancer_ingress[0].hostname
}