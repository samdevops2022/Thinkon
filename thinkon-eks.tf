module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"

  name = "eks-vpc"

  cidr = "10.0.0.0/16"

  azs             = ["ca-central-1a" ,"ca-central-1b"]
  private_subnets = var.vpc_private_subnets
  public_subnets  = var.vpc_public_subnets


  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

module "eks" {
  source = "terraform-aws-modules/eks/aws"
  cluster_name = "my-eks-cluster"
  vpc_id = module.vpc.vpc_id
  subnet_ids = module.vpc.public_subnets

eks_managed_node_group_defaults = {
      instance_type = "t2.medium"
      desired_size = 4
    }
  
tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}