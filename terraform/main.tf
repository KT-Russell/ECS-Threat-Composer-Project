module "vpc" {
  source             = "./modules/vpc"
  vpc_cidr           = var.vpc_cidr
  public_subnets     = var.public_subnets
  availability_zones = var.availability_zones
  tags               = var.tags
}

# ALB Module 
module "alb" {
  source = "./modules/alb"

  alb_name           = "threat-mod-alb"
  vpc_id             = module.vpc.vpc_id
  public_subnets_ids = module.vpc.public_subnets_ids

  target_type       = var.target_type
  target_group_name = var.target_group_name
  health_check_path = var.health_check_path

  ssl_policy      = var.ssl_policy
  certificate_arn = module.acm.certificate_arn
}


module "iam_roles" {
  source                  = "./modules/iam_roles"
  ecs_execution_role_name = var.ecs_execution_role_name
  ecs_task_role_name      = var.ecs_task_role_name
  tags                    = var.tags
  ecs_assume_service      = var.ecs_assume_service
}



module "ecs" {
  source = "./modules/ecs"

  vpc_id               = module.vpc.vpc_id
  lb_security_group_id = module.alb.alb_security_group_id

  #logging

  region            = var.region
  log_group         = "/ecs/threat-mod-app"
  create_group      = "true"
  log_stream_prefix = "threat-mod"


  #ecs cluster settings
  cluster_name          = var.cluster_name
  cluster_insight_name  = var.cluster_insight_name
  cluster_insight_value = var.cluster_insight_value

  #ecs Service
  service_name  = var.service_name
  desired_count = var.desired_count

  #ecs Task Definition
  execution_role_arn = module.iam_roles.ecs_execution_role_arn
  task_cpu           = var.task_cpu
  task_family        = var.task_family
  task_memory        = var.task_memory
  container_name     = var.container_name
  container_port     = var.container_port
  image_url          = "${data.aws_ecr.repository_url}:latest"

  # networkorking
  subnet_ids         = module.vpc.public_subnets_ids
  security_group_ids = [module.ecs.ecs_service_security_group_id]

  # load balancer 
  lb_target_group_arn = module.alb.target_group_arn
}


# ACM 
module "acm" {
  source = "./modules/acm"

  domain_name        = "tm.kamranr.com"
  alternative_names  = []
  cloudflare_zone_id = var.cloudflare_zone_id
  cloudflare_api_token = var.cloudflare_api_token
  
}

# Cloudlfare DNS for app Domain 
resource "cloudflare_record" "app_domain" {
  zone_id = var.cloudflare_zone_id
  name    = "tm"
  type    = "CNAME"
  content = module.alb.alb_dns_name
  proxied = false
  ttl     = 300

}