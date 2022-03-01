data "aws_iam_policy" "kinesis_full_access" {
  name = "AmazonKinesisFullAccess"
}

data "aws_iam_policy" "ecs_full_access" {
  name = "AmazonECS_FullAccess"
}

data "aws_iam_policy" "cloudwatchlogs_full_access" {
  name = "CloudWatchLogsFullAccess"
}

data "aws_iam_policy_document" "ecs_tasks" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "ecs" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs.amazonaws.com", "ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "pyrami_container" {
  name                = "PyramiContainer"
  assume_role_policy  = data.aws_iam_policy_document.ecs_tasks.json
  managed_policy_arns = [data.aws_iam_policy.kinesis_full_access.arn]
}

resource "aws_iam_role" "ecs_executor" {
  name                = "EcsExecutor"
  assume_role_policy  = data.aws_iam_policy_document.ecs.json
  managed_policy_arns = [
    data.aws_iam_policy.ecs_full_access.arn,
    data.aws_iam_policy.cloudwatchlogs_full_access.arn
  ]
}

resource "aws_iam_user" "pyrami" {
  name = "pyrami"
}

resource "aws_iam_user_policy_attachment" "pyrami_attach" {
  user       = aws_iam_user.pyrami.name
  policy_arn = data.aws_iam_policy.kinesis_full_access.arn
}