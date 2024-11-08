resource "sumologic_collector" "vpcflowlog" {
  name        = "vpcflowlog"
  description = "Collecotor using vpc flow from aws s3"
  category    = "aws/s3"
}