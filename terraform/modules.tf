#terraform-ansible/modules.tf

locals {
  cluster-name = "${var.name-prefix}-eks-cluster-${var.initials}"
}

module "vpc" {
  source       = "./modules/vpc"
  initials     = var.initials
  region       = var.region
  name-prefix  = var.name-prefix
  cluster-name = local.cluster-name
}

module "servers" {
  source          = "./modules/servers"
  initials        = var.initials
  region          = var.region
  name-prefix     = var.name-prefix
  subnet_id       = module.vpc.public_subnets[0].id
  allow_ssh_sg_id = module.vpc.allow_ssh_sg_id
}

module "eks" {
  source         = "./modules/eks-cluster"
  initials       = var.initials
  region         = var.region
  name-prefix    = var.name-prefix
  cluster-name   = local.cluster-name
  vpc_id         = module.vpc.vpc_id
  public_subnets = [for s in module.vpc.public_subnets : s.id]
}

module "kubernetes" {
  source           = "./modules/deployments"
  initials         = var.initials
  region           = var.region
  name-prefix      = var.name-prefix
  cluster_name     = local.cluster-name
  cluster_endpoint = module.eks.endpoint
  cluster_cert     = module.eks.cert
}

module "storage" {
  source = "./modules/storage"
}
