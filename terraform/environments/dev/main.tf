provider "aws" {
    region = var.aws_region
}

data "aws_availability_zones" "available" {}

# VPC Module
module "vpc" {
    source  = "terraform-aws-modules/vpc/aws"
    version = "5.1.1"

    name    = var.vpc_name
    cidr    = var.vpc_cidr

    azs             = slice(data.aws_availability_zones.names, 0, 2)
    private_subnets = var.private_subnets
    public_subnets  = var.public_subnets

    enable_nat_gateway = true
    single_nat_gateway = true

    tags = {
        Environment = "dev"
        Project = "edguillen-eks"
    }
}

# EKS Module
module "eks" {
    source  = "terraform-aws-modules/eks/aws"
    version = "20.8.4"

    cluster_name    = var.cluster_name
    cluster_version = var.k8s_version

    subnet_ids  = module.vpc.private_subnets
    vpc_id      = module.vpc.vpc_id

    enable_irsa = true

    eks_managed_node_groups = {
        default = {
            min_size        = 1
            max_size        = 3
            desired_size    = 2

            instance_types = ["t3.medium"]
            capacity_type  = "ON_DEMAND"
        }
    }

    tags = {
        Environment = "dev"
        Project     = "edguillen-eks"
    }
}

data "aws_availability_zones" "available" {}