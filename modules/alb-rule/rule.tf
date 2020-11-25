resource "aws_lb_listener_rule" "alb_rule" {
  listener_arn = var.listener_arn
  priority     = var.priority

  action {
    type             = "forward"
    target_group_arn = var.target_group_arn
  }

  # legacy code
  condition {
    dynamic host_header {
      for_each = var.condition_field == "host-header" ? [1] : []
      content {
        values = var.condition_values
      }
    }
    dynamic path_pattern {
      for_each = var.condition_field == "path-pattern" ? [1] : []
      content {
        values = var.condition_values
      }
    }
  }
  # more flexible approach
  dynamic condition {
    for_each = var.conditions
    dynamic host_header {
      for_each = each.value.field == "host-header" ? [1] : []
      content {
        values = each.value.values
      }
    }
    dynamic path_pattern {
      for_each = each.value.field == "path-pattern" ? [1] : []
      content {
        values = each.value.values
      }
    }
    dynamic query_string {
      for_each = each.value.field == "query-string" ? [1] : []
      content {
        values = each.value.values
      }
    }
  }
}

