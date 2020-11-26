variable "vpc_id" {
}

variable "aws_region" {
}

variable "launch_type" {
}

variable "application_name" {
}

variable "application_port" {
}

variable "application_version" {
}

variable "cluster_arn" {
}

variable "service_role_arn" {
  default = ""
}

variable "desired_count" {
}

variable "deployment_minimum_healthy_percent" {
  default = 100
}

variable "deployment_maximum_percent" {
  default = 200
}

variable "deregistration_delay" {
  default = 30
}

variable "healthcheck_matcher" {
  default = "200"
}

variable "cpu_reservation" {
}

variable "memory_reservation" {
}

variable "log_group" {
}

variable "task_role_arn" {
  default = ""
}

variable "execution_role_arn" {
  default = ""
}

variable "alb_arn" {
}

variable "fargate_service_security_groups" {
  default = []
}

variable "fargate_service_subnetids" {
  default = []
}

variable "secrets" {
  description = "secrets to set"
  default     = []
  type = list(object({
    name      = string
    valueFrom = string
  }))
}

variable "container_cpu" {
}

variable "container_memory" {
}

variable "ingress_rules" {
  default     = []
  type = list(object({
    from_port  = number
    to_port = number
  }))
}
