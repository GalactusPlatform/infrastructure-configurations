module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_name    = var.cluster_name
  cluster_version = "1.31"

  providers = {
    aws = aws
  }

  cluster_endpoint_public_access = true

  create_kms_key              = false
  create_cloudwatch_log_group = false
  cluster_encryption_config   = {}

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
    aws-ebs-csi-driver = {
      most_recent = true
    }
  }

  vpc_id                   = var.vpc_id
  subnet_ids               = var.private_subnets
  control_plane_subnet_ids = var.private_subnets

  eks_managed_node_group_defaults = {
    instance_types = ["m5.xlarge", "m5.large", "t3.medium"]
    iam_role_additional_policies = {
      AmazonEBSCSIDriverPolicy = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
    }
  }

  eks_managed_node_groups = {
    default = {
      min_size     = 1
      max_size     = 10
      desired_size = 2
    }
  }

  manage_aws_auth_configmap = true

  aws_auth_roles = [
    {
      rolearn  = var.scope_manager_role
      username = "scope_manager_role"
      groups   = ["system:masters"]
    },
    {
      rolearn  = var.telemetry_manager_role
      username = "telemetry_manager_role"
      groups   = ["eks:k8s-metrics", "np:pod-reader", "system:masters"]
    },
    {
      rolearn  = "arn:aws:iam::481665089566:role/github"
      username = "github"
      groups   = ["system:masters"]
    },
    {
      rolearn  = "arn:aws:iam::481665089566:role/aws-reserved/sso.amazonaws.com/AWSReservedSSO_Administrator_Access_SSO_191d158c6a53b5e1"
      username = "AWSReservedSSO_Administrator_Access_SSO_191d158c6a53b5e1"
      groups   = ["system:masters"]
    },
    {
      rolearn  = "arn:aws:iam::481665089566:role/aws-reserved/sso.amazonaws.com/AWSReservedSSO_Owner_Access_SSO_ed1fea9453f242c7"
      username = "AWSReservedSSO_Owner_Access_SSO_ed1fea9453f242c7"
      groups   = ["system:masters"]
    },
    {
      rolearn  = "arn:aws:iam::481665089566:role/genesys_admin"
      username = "481665089566"
      groups   = ["system:masters"]
    },
    {
      rolearn  = "arn:aws:iam::481665089566:user/david.cohan"
      username = "davidcohan"
      groups   = ["system:masters"]
    },
  ]

  tags = {
    organization = var.organization
    account      = var.account
  }
}

