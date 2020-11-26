[
  {
    "name": "${application_name}",
    "image": "${ecr_url}:${application_version}",
    "cpu": ${cpu_reservation},
    "memoryreservation": ${memory_reservation},
    "essential": true,
    "mountpoints": [],
    "portmappings" : [
      {
        "containerport": ${application_port},
        "hostport": ${host_port}
      }
    ],
    ${jsonencode({
      "secrets": [for secret in secrets : secret ],
    })}
    "logconfiguration": {
          "logdriver": "awslogs",
          "options": {
              "awslogs-group": "${log_group}",
              "awslogs-region": "${aws_region}",
              "awslogs-stream-prefix": "${application_name}"
          }
    }
  }
]
