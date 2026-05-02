module "vpc" {
  source              = "./modules/vpc"
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidrs = var.public_subnet_cidrs
  app_subnet_cidrs    = var.app_subnet_cidrs
  db_subnet_cidrs     = var.db_subnet_cidrs
  availability_zones  = var.availability_zones
  project_name        = var.project_name
}

module "security_groups" {
  source       = "./modules/security_groups"
  vpc_id       = module.vpc.vpc_id
  project_name = var.project_name
}

module "alb" {
  source            = "./modules/alb"
  project_name      = var.project_name
  vpc_id            = module.vpc.vpc_id
  alb_sg_id         = module.security_groups.alb_sg_id
  public_subnet_ids = module.vpc.public_subnet_ids
}

module "asg" {
  source           = "./modules/asg"
  project_name     = var.project_name
  ami_id           = var.ami_id
  instance_type    = var.instance_type
  key_name         = var.key_name
  app_sg_id        = module.security_groups.app_sg_id
  app_subnet_ids   = module.vpc.app_subnet_ids
  target_group_arn = module.alb.target_group_arn
}

module "compute" {
  source           = "./modules/compute"
  project_name     = var.project_name
  ami_id           = var.ami_id
  instance_type    = var.instance_type
  key_name         = var.key_name
  public_subnet_id = module.vpc.public_subnet_ids[0]
  db_subnet_id     = module.vpc.db_subnet_ids[0]
  bastion_sg_id    = module.security_groups.bastion_sg_id
  db_sg_id         = module.security_groups.db_sg_id
}
