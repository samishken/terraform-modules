variable "listener_arn" {
}

variable "priority" {
}

variable "target_group_arn" {
}

variable "condition_field" {
}

variable "condition_values" {
  type = list(string)
}

variable "conditions" {
  description = "ALB rule conditions"
  default     = []
  type = list(object({
    field  = string
    values = list(string)
  }))
}
