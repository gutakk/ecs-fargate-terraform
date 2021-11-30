provider "aws" {
  region     = var.region
  access_key = var.spoke_aws_account.access_key
  secret_key = var.spoke_aws_account.secret_key
}

module "security_group" {
  source = ".././modules/security_group"

  app_name    = var.app_name
  vpc_id      = var.vpc_id
  owner       = var.owner
  environment = var.environment
}

module "keypair" {
  source = ".././modules/keypair"

  key_name = var.app_name
}

module "log" {
  source = ".././modules/log"

  app_name    = var.app_name
  owner       = var.owner
  environment = var.environment
}

module "alb" {
  source = ".././modules/alb"

  app_name           = var.app_name
  environment        = var.environment
  owner              = var.owner
  public_subnets     = var.vpc_public_subnets
  vpc_id             = var.vpc_id
  security_group_ids = module.security_group.alb_security_group_ids
}

module "ecr" {
  source = ".././modules/ecr"

  app_name = var.app_name
  owner    = var.owner
}

module "ecs" {
  source = ".././modules/ecs"

  app_name                  = var.app_name
  environment               = var.environment
  owner                     = var.owner
  cluster_name              = var.cluster_name
  lb_target_group_arn       = module.alb.lb_target_group_arn
  lb_listener               = module.alb.lb_listener
  desired_count             = 2
  cloudwatch_log_group_name = module.log.cloudwatch_log_group_name
  ecr_repository_url        = module.ecr.repository_url
  private_subnets           = var.vpc_private_subnets
  cpu                       = 512
  memory                    = 1024
  security_group_ids        = module.security_group.ecs_security_group_ids
}
