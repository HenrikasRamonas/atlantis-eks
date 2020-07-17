### Configuring eks-readonly role in AWS IAM - policy, role and policy attachment ###
resource "aws_iam_policy" "eks-readonly-policy" {
  name        = "eks_readonly_policy"
  path        = "/"
  description = "Read only policy for eks-readonly role"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": {
    "Sid": "45345354354",
    "Effect": "Allow",
    "Action": [
      "eks:DescribeCluster",
      "eks:ListCluster"
    ],
    "Resource": "*"
    }
}
EOF
}

resource "aws_iam_role" "eks-readonly-role" {
  name = "eks_readonly"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "AWS": "arn:aws:iam::${var.aws_acccount_id}:root"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "eks-readonly-policy-attach" {
  role       = aws_iam_role.eks-readonly-role.name
  policy_arn = aws_iam_policy.eks-readonly-policy.arn
}

### Configuring eks-admin role in AWS IAM - policy, role and policy attachment ###
resource "aws_iam_policy" "eks-admin-policy" {
  name        = "eks_admin_policy"
  path        = "/"
  description = "Admin policy for eks-admin role"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": {
    "Sid": "45345354354",
    "Effect": "Allow",
    "Action": [
      "*"
    ],
    "Resource": "*"
    }
}
EOF
}

resource "aws_iam_role" "eks-admin-role" {
  name = "eks_admin"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "AWS": "arn:aws:iam::${var.aws_acccount_id}:root"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "eks-admin-policy-attach" {
  role       = aws_iam_role.eks-admin-role.name
  policy_arn = aws_iam_policy.eks-admin-policy.arn
}