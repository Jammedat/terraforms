resource "aws_cloudwatch_metric_alarm" "main" {
  alarm_name                = "xfusion-alarm"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = 1
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  statistic                 = "Average"
  period                    = 300
  threshold                 = 80
}