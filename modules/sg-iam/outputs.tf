output eks_readonly_role_arn {
  description = "EKS cluster eks_readonly role ARN"
  value = aws_iam_role.eks-readonly-role.arn
}

output eks_admin_role_arn {
  description = "EKS cluster eks_admin role ARN"
  value = aws_iam_role.eks-admin-role.arn
}

output worker_management_sg {
  description = "Cluster workers management security group id"
  value = aws_security_group.worker_group_mgmt_one.id
}