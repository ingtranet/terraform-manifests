resource "aws_kinesis_stream" "mirror_to_mdc" {
  name = "mirror-to-mdc-kafka"
  shard_count = 1

  stream_mode_details {
    stream_mode = "PROVISIONED"
  }
}