#terraform-ansible/modules.tf

module "vpc" {
  source      = "./modules/vpc"
  initials    = var.initials
  region      = var.region
  name-prefix = var.name-prefix
  #cluster-name = "${var.name-prefix}-vpc-${var.initials}"
}

module "servers" {
  source          = "./modules/servers"
  initials        = var.initials
  region          = var.region
  name-prefix     = var.name-prefix
  subnet_id       = module.vpc.public_subnets[0].id
  allow_ssh_sg_id = module.vpc.allow_ssh_sg_id
}

# module "eks" {
#   source         = "./modules/eks-cluster"
#   initials       = var.initials
#   region         = var.region
#   name-prefix    = var.name-prefix
#   cluster-name   = "${var.name-prefix}-eks-cluster-${var.initials}"
#   vpc_id         = module.vpc.vpc_id
#   public_subnets = module.vpc.public_subnet_ids
# }
