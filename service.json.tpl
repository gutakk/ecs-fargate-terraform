[
  {
    "name": "${app_name}",
    "image": "${ecr_repository_url}:latest",
    "cpu": 10,
    "memory": 256,
    "essential": true,
    "portMappings": [
      {
        "containerPort": 80,
        "hostPort": 80,
        "protocol": "tcp"
      }
    ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": { 
        "awslogs-group" : "${cloudwatch_log_group_name}",
        "awslogs-stream-prefix": "${app_name}-api",
        "awslogs-region": "ap-southeast-1"
      }
    }
  }
]
