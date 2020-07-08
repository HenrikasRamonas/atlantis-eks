data "aws_caller_identity" "current" {}

// Atlantis variables
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

variable aws_access_key_atlantis {
  description = "AWS account access key used by Atlantis to provision resources on AWS"
}

variable aws_secret_access_key_atlantis {
  description = "AWS account secret access key used by Atlantis to provision resources on AWS"
}

//Module install Atlantis from Helm 
module "kubernetes" {
  source = "./modules/kubernetes"
  github_secret = var.github_secret
  github_token = var.github_token
  github_user = var.github_user
  github_whitelist = var.github_whitelist
  aws_access_key = var.aws_access_key_atlantis
  aws_secret_access_key = var.aws_secret_access_key_atlantis
  aws_account_id = data.aws_caller_identity.current.account_id
  cluster_name = local.cluster_name
  aws_region = var.region
}

//security groups and IAM
module "sg-iam" {
  source = "./modules/sg-iam"
  aws_acccount_id = data.aws_caller_identity.current.account_id
  vpc_id = module.vpc.vpc_id
  cluster_oidc_issuer_url = module.eks.cluster_oidc_issuer_url
  eks_cluster_id = local.cluster_name
  k8s_service_account_name = local.k8s_service_account_name
  k8s_service_account_namespace = local.k8s_service_account_namespace
}