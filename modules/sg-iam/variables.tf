variable vpc_id {
  description = "VPC ID"
}

variable aws_acccount_id {
  description = "AWS account ID used for Atlantis"
}

variable eks_cluster_id {
  description = "EKS cluster name"
}

variable k8s_service_account_namespace {
  description = "Namespace used for autoscaler deployment"
}

variable k8s_service_account_name {
  description = "K8s autoscaler service account name"
}

variable cluster_oidc_issuer_url {
  description = "Cluster OpenID Connect URL"
}