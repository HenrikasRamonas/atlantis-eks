# Atlantis Terraform deployment on AWS EKS.

This is a demo on using Terraform to provision an EKS cluster and using Helm to install Atlantis. 

Demonstration is based on HashiCorp course [Provision an AWS EKS Cluster](https://learn.hashicorp.com/terraform/kubernetes/provision-eks-cluster), [Terraform aws modules](https://github.com/terraform-aws-modules) such as terraform-aws-vpc, terraform-aws-eks and others.

Push request could be found [here](https://github.com/HenrikasRamonas/atlantis-test).

## Prerequisites
Demonstration is performed from windows machine via Windows PowerShell.

- [AWS CLI](https://aws.amazon.com/cli/) (Windows: choco install awscli)
- [AWS IAM Authenticator](https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html) (Windows: choco install aws-iam-authenticator)
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) (Windows: choco install kubernetes-cli)
- [wget](https://www.gnu.org/software/wget/) (Windows: choco install wget)
- [Terraform v0.12.28](https://www.terraform.io/)
- [Helm](https://github.com/helm/helm/releases)

## Prepare configuration
Change terraform.tfvars according to your needs.

## Deployment
Initialize and apply terraform with variables
```bash 
$ terraform init
$ terraform apply -var-file=terraform.tfvars
```

on windows machine if appears error below
```terraform
Error: Error running command 'for i in `seq 1 60`; do wget --no-check-certificate -O - -q $ENDPOINT/healthz >/dev/null && exit 0 || true; sleep 5; done; echo TIMEOUT && exit 1': exec: "/bin/sh": file does not exist. Output:
```
resolution is update varbiables in file .terraform\modules\eks\terraform-aws-eks-12.1.0\variables.tf 
```terraform
wait_for_cluster_interpreter 
  from default = ["/bin/sh", "-c"] 
  to default = ["c:/git/bin/sh.exe", "-c"]
wait_for_cluster_cmd 
  from default = "for i in `seq 1 60`; do wget --no-check-certificate -O - -q $ENDPOINT/healthz >/dev/null && exit 0 || true; sleep 5; done; echo TIMEOUT && exit 1" 
  to default = "until curl -sk $ENDPOINT >/dev/null; do sleep 4; done"
```
rerun terraform 
```bash 
$ terraform apply -var-file=terraform.tfvars
```
## IAM admin and read-only roles.
Use in two different terminal windows commands below for roles credentionals extract:
```terraform
aws sts assume-role --role-arn "arn:aws:iam::<aws-account-id>:role/eks_admin" --role-session-name eks_admin_role

aws sts assume-role --role-arn "arn:aws:iam::<aws-account-id>:role/eks_readonly" --role-session-name eks_readonly_role
```

## Clear demo environment
```bash 
$ terraform destroy -var-file=terraform.tfvars
```
