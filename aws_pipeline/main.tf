provider "aws" {
    region  = "us-east-2"    
}

module "vpc"{
  source = "./modules/vpc"
}

module "ecs"{
  source                = "./modules/ecs"
  private_subnet_b      = module.vpc.subnet_id
  security_group_id_vpc = module.vpc.security_group_id
  target_group_alb      = module.alb.target_group
  cluster_name          = var.cluster_name
  service_name          = var.service_name
  memory                = var.memory
  cpu                   = var.cpu
  desired_count         = var.desired_count
  container_port        = var.container_port
  resource_name         = var.resource_name
}

module "alb"{
  source                = "./modules/alb"
  private_subnet_b      = module.vpc.subnet_id
  security_group_id_vpc = module.vpc.security_group_id
  vpc_for_alb           = module.vpc.aws_vpc
  public_subnet_a       = module.vpc.subnet_id_a
}

module "endp" {
  source                = "./modules/endp"
  vpc_id                = module.vpc.aws_vpc
  aws_route_tables      = module.vpc.aws_route_table
  private_subnet_b      = module.vpc.subnet_id
  security_group_id_vpc = module.vpc.security_group_id
}

module "codepipeline" {
  source                = "./modules/codepipeline"
  iam_policy_arn        = var.iam_policy_arn
  private_subnet_b      = module.vpc.subnet_id
  security_group_id_vpc = module.vpc.security_group_id
  vpc_id                = module.vpc.aws_vpc
  resource_name         = var.resource_name
  project_name          = var.project_name
  fullRepositoryId      = var.fullRepositoryId
  branchName            = var.branchName
  bucket_name           = var.bucket_name
  buildspec             = var.buildspec
  cluster_name          = var.cluster_name
  service_name          = var.service_name
  
}