# terraform-modules
repository of useful terraform modules

# Usage


## ECS Cluster (EC2)
```
module "my-ecs" {
  source         = "github.com/in4it/terraform-modules//modules/ecs-cluster"
  VPC_ID         = "vpc-id"
  CLUSTER_NAME   = "my-ecs"
  INSTANCE_TYPE  = "t2.small"
  SSH_KEY_NAME   = "mykeypairName"
  VPC_SUBNETS    = "subnetId-1,subnetId-2"
  ENABLE_SSH     = true
  SSH_SG         = "my-ssh-sg"
  LOG_GROUP      = "my-log-group"
  AWS_ACCOUNT_ID = "1234567890"
  AWS_REGION     = "us-east-1"
}
```

## ECS Cluster (Fargate)
```
module "my-ecs" {
  source         = "github.com/in4it/terraform-modules//modules/fargate-cluster"
  cluster_name   = "my-ecs"
  log_group      = "my-log-group"
}
```

## ECS Service
```
module "my-service" {
  source              = "github.com/in4it/terraform-modules//modules/ecs-service"
  vpc_id              = "vpc-id"
  application_name    = "my-service"
  application_port    = "8080"
  application_version = "latest"
  cluster_arn         = "${module.my-ecs.cluster_arn}"
  service_role_arn    = "${module.my-ecs.service_role_arn}"
  aws_region          = "us-east-1"
  healthcheck_matcher = "200"
  cpu_reservation     = "1024"
  memory_reservation  = "1024"
  log_group           = "my-log-group"
  desired_count       = 2
  alb_arn             = "${module.my-alb.alb_arn}"
  launch_type         = "FARGATE"
  security_groups     = [""]
  subnets             = [""]
}
```

## ALB
```
module "my-alb" {
  source             = "github.com/in4it/terraform-modules/modules/alb"
  VPC_ID             = "vpc-id"
  ALB_NAME           = "my-alb"
  VPC_SUBNETS        = "subnetId-1,subnetId-2"
  DEFAULT_TARGET_ARN = "${module.my-service.target_group_arn}"
  DOMAIN             = "*.my-ecs.com"
  INTERNAL           = false
  ECS_SG             = "${module.my-ecs.cluster_sg}"
}
```

## ALB Rule
```
module "my-alb-rule" {
  source             = "github.com/in4it/terraform-modules/modules/alb-rule"
  LISTENER_ARN       = "${module.my-alb.http_listener_arn}"
  PRIORITY           = 100
  TARGET_GROUP_ARN   = "${module.my-service.target_group_arn}"
  CONDITION_FIELD    = "host-header"
  CONDITION_VALUES   = ["subdomain.my-ecs.com"]
}
```
