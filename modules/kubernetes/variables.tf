variable github_user {
  description = "GitHub account name used to setup Atlantis"
}

variable github_token {
  description = "GitHub account token used to setup Atlantis"
}

variable github_secret {
  description = "GitHub account secret used to setup Atlantis"
}

variable github_whitelist {
  description = "Repositories list which Atlantis could access"
}

variable aws_access_key {
  description = "AWS account access key used by Atlantis to provision resources on AWS"
}

variable aws_secret_access_key {
  description = "AWS account secret access key used by Atlantis to provision resources on AWS"
}

variable cluster_name {
  description = "EKS cluster name"
}

variable aws_account_id {
  description = "AWS account ID used for RBAC configuration"
}

variable aws_region {
  description = "AWS region where infrastructure is deployed"
}