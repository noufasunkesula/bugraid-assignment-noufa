module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.21.0"

  cluster_name    = "bugraid-noufa-eks"
  cluster_version = "1.29"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  enable_irsa = true

  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = true

  # ✅ Enable control plane logs (for CloudWatch)
  cluster_enabled_log_types = [
    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler"
  ]

  eks_managed_node_groups = {
    bugraid-noufa-ng = {
      desired_size = 2
      max_size     = 3
      min_size     = 1

      instance_types = ["t3.medium"]

      labels = {
        role = "bugraid-noufa-worker"
      }

      tags = {
        Name = "bugraid-noufa-node"
      }
    }
  }

  tags = {
    Environment = "bugraid-noufa"
    Project     = "bugraid-assignment"
  }
}
