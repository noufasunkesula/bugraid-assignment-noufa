resource "aws_cloudwatch_metric_alarm" "bugraid_noufa_cpu_high" {
  alarm_name          = "bugraid-noufa-eks-highcpu"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EKS"
  period              = 60
  statistic           = "Average"
  threshold           = 70
  alarm_description   = "This alarm triggers if EKS cluster CPU > 70% for 2 mins"

  dimensions = {
    ClusterName = module.eks.cluster_name
  }

  alarm_actions = [] # Optional: Add SNS topic ARN
}
