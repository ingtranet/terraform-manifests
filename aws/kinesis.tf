resource "aws_kinesis_stream" "mirror_to_mdc" {
  name = "mirror-to-mdc-kafka"

  stream_mode_details {
    stream_mode = "ON_DEMAND"
  }
}