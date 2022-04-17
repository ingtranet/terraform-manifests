resource "aws_ecs_cluster" "fargate_default" {
  name = "fargate-default"
}

resource "aws_ecs_task_definition" "pyrami_twitter_stream" {
  family                   = "pyrami-twitter-stream"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 256
  memory                   = 512
  task_role_arn            = aws_iam_role.pyrami_container.arn
  execution_role_arn       = aws_iam_role.ecs_executor.arn
  network_mode             = "awsvpc"
  container_definitions = <<TASK_DEFINITION
[
  {
    "name": "pyrami-twitter-stream",
    "image": "cookieshake/pyrami",
    "cpu": 256,
    "memory": 512,
    "essential": true,
    "environment": [
      {"name": "VERSION", "value": "13"},
      {"name": "PYRAMI_APP", "value": "twitter_stream"},
      {"name": "PYRAMI_BEARER_TOKEN", "value": "${var.twitter_bearer_token}"},
      {"name": "PYRAMI_KINESIS_STREAM", "value": "${aws_kinesis_stream.mirror_to_mdc.name}"},
      {"name": "PYRAMI_KAFKA_TOPIC", "value": "data.twitter.sampled-stream.1"}
    ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "${aws_cloudwatch_log_group.pyrami_container.name}",
        "awslogs-region": "ap-northeast-2",
        "awslogs-stream-prefix": "ecs"
      }
    }
  }
]
TASK_DEFINITION
}

resource "aws_ecs_service" "pyrami-twitter-stream" {
  name            = "pyrami-twitter-stream"
  cluster         = aws_ecs_cluster.fargate_default.id
  launch_type     = "FARGATE"
  task_definition = aws_ecs_task_definition.pyrami_twitter_stream.arn
  desired_count   = 1
  depends_on      = [aws_iam_role.pyrami_container]
  deployment_maximum_percent = 100
  deployment_minimum_healthy_percent = 0
  network_configuration {
    subnets = data.aws_subnets.default.ids
    assign_public_ip = true
  }
}
