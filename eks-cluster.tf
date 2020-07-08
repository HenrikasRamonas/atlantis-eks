variable ssh_public_key {
}

resource "aws_key_pair" "eks_workers_key" {
  key_name   = "eks-workers-key"
  public_key = var.ssh_public_key
}

module "eks" {
  source       = "terraform-aws-modules/eks/aws"
  cluster_name = local.cluster_name
  subnets      = module.vpc.private_subnets
  vpc_id = module.vpc.vpc_id

  tags = {
    Environment = "demo"
  }

  worker_groups = [
    {
      name                          = "worker-group-1"
      instance_type                 = "t2.small"
      additional_userdata           = "echo foo bar"
      asg_desired_capacity          = 1
      asg_min_size                  = 1
      asg_max_size                  = 2

      additional_security_group_ids = [aws_security_group.worker_group_mgmt_one.id]

      //Tags needed to enable EKS cluster nodes autoscaling
      tags = [
        {
          "key"                 = "k8s.io/cluster-autoscaler/enabled"
          "propagate_at_launch" = "false"
          "value"               = "true"
        },
        {
          "key"                 = "k8s.io/cluster-autoscaler/${local.cluster_name}"
          "propagate_at_launch" = "false"
          "value"               = "true"
        }
      ]

    }
  ]
  map_roles = local.role-map-list
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}
