### Atlantis Helm variables.yaml file and Helm release setup ##
data "template_file" "atlantis_values" {
  template = <<EOF
github:
  user: ${var.github_user}
  token: ${var.github_token}
  secret: ${var.github_secret}
orgWhitelist: ${var.github_whitelist}
ingress:
  enabled: false
aws:
  credentials: |
    [default]
    aws_access_key_id=${var.aws_access_key}
    aws_secret_access_key=${var.aws_secret_access_key}
  config: |
    [default]
EOF
}

resource "helm_release" "atlantis" {
  name        = "atlantis"
  chart       = "stable/atlantis"
  values      = [data.template_file.atlantis_values.rendered]
}

### AWS EKS workers autoscaler Helm variables.yaml file and Helm release setup ##
data "template_file" "autoscaler_values" {
  template = <<EOF
awsRegion: ${var.aws_region}
rbac:
  create: true
  serviceAccountAnnotations:
    eks.amazonaws.com/role-arn: "arn:aws:iam::${var.aws_account_id}:role/cluster-autoscaler"
autoDiscovery:
  clusterName: ${var.cluster_name}
  enabled: true
EOF
}

resource "helm_release" "eks_cluster_autoscaler" {
  name        = "cluster-autoscaler"
  chart       = "stable/cluster-autoscaler"
  namespace = "kube-system"
  values      = [data.template_file.autoscaler_values.rendered]

}
