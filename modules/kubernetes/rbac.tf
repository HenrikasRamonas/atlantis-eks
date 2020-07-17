## K8s RBAC role bindings for eks-readonly role and for eks-admin role ##

## Custom eks-readonly user role ###
resource "kubernetes_cluster_role" "eks-readonly-user-role" {
  metadata {
    name = "eks-readonly-user-role"
  }
  rule {
    api_groups = [""]
    resources  = ["*"]
    verbs      = ["get", "list", "watch"]
  }
  rule {
    api_groups = ["extensions"]
    resources  = ["*"]
    verbs      = ["get", "list", "watch"]
  }
  rule {
    api_groups = ["apps"]
    resources  = ["*"]
    verbs      = ["get", "list", "watch"]
  }
}

resource "kubernetes_cluster_role_binding" "eks-readonly-user-role-binding" {
  metadata {
    name      = "eks-readonly-user-role-binding"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "eks-readonly-user-role"
  }
  subject {
    kind      = "User"
    name      = "eks-readonly"
    api_group = "rbac.authorization.k8s.io"
  }
}

resource "kubernetes_cluster_role_binding" "eks-admin-user-role-binding" {
  metadata {
    name      = "eks-admin-user-role-binding"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }
  subject {
    kind      = "User"
    name      = "eks-admin"
    api_group = "rbac.authorization.k8s.io"
  }
}