resource "aws_cloudwatch_log_group" "pyrami_container" {
  name = "pyrami-container"
  retention_in_days = 3
}