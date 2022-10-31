resource "aws_autoscaling_group" "main_asg" {
  name                      = replace(local.name, "rtype", "asg")
  max_size                  = var.max_size
  min_size                  = var.min_size
  health_check_grace_period = 60
  health_check_type         = "EC2"
  desired_capacity          = var.desired_capacity
  force_delete              = var.force_delete
  launch_configuration      = aws_launch_configuration.main.name
  vpc_zone_identifier       = var.vpc_zone_identifier
  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
  }
}

resource "aws_autoscaling_attachment" "asg_attachment_bar" {
  autoscaling_group_name = aws_autoscaling_group.main_asg.id
  lb_target_group_arn    = var.lb_target_group_arn
}

resource "aws_autoscaling_policy" "scale_out" {
  name                   = replace(local.name, "rtype", "out")
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.main_asg.name
}

resource "aws_cloudwatch_metric_alarm" "cloudwatch_alarm_out" {
  alarm_name          = replace(local.name, "rtype", "out")
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = 70
  tags                = merge(local.common_tags, { Name = replace(local.name, "rtype", "out-main") })
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.main_asg.name
  }

  alarm_description = "This metric monitors average EC2 instance CPU utilization"
  alarm_actions     = [aws_autoscaling_policy.scale_out.arn]
}

resource "aws_autoscaling_policy" "scale_in" {
  name                   = replace(local.name, "rtype", "in")
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.main_asg.name
}

resource "aws_cloudwatch_metric_alarm" "cloudwatch_scale_in" {
  alarm_name          = replace(local.name, "rtype", "in")
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = 10
  tags                = merge(local.common_tags, { Name = replace(local.name, "rtype", "in-main") })
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.main_asg.name
  }

  alarm_description = "This metric monitors average EC2 instance CPU utilization"
  alarm_actions     = [aws_autoscaling_policy.scale_in.arn]
}
