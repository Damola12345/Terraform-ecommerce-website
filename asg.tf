# Create a Launch Template
# terraform aws launch template
resource "aws_launch_template" "webserver-launch-template" {
  name          = "${var.launch-template-name}"
  image_id      = "${var.ec2-image-id}"
  instance_type = "${var.ec2-instance-type}"
  key_name      = "${var.ec2-key-pair-name}"
  description   = "Launch Template for Auto Scaling Group"

  monitoring {
    enabled = true
  }

  vpc_security_group_ids = [aws_security_group.webserver-security-group.id]
}

# Create Auto Scaling Group
# terraform aws autoscaling group
resource "aws_autoscaling_group" "auto-scaling-group" {
  vpc_zone_identifier = [aws_subnet.private-subnet-1.id, aws_subnet.private-subnet-2.id]
  desired_capacity    = 2
  max_size            = 4
  min_size            = 1
  name                = "Test Auto Scaling Group"
  health_check_type   = "ELB"

  launch_template {
    name    = aws_launch_template.webserver-launch-template.name
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "ASG-Web-Server"
    propagate_at_launch = true
  }

  lifecycle {
    ignore_changes      = [target_group_arns]
  }
}

# Attach Auto Scaling Group to ALB Target Group
# terraform aws autoscaling attachment
resource "aws_autoscaling_attachment" "asg-alb-target-group-attachment" {
  autoscaling_group_name = aws_autoscaling_group.auto-scaling-group.id
  alb_target_group_arn   = aws_lb_target_group.alb-target-group.arn
}

# Create an Auto Scaling Group Notification
# terraform aws autoscaling notification
resource "aws_autoscaling_notification" "webserver-asg-notifications" {
  group_names = [aws_autoscaling_group.auto-scaling-group.name]

  notifications = [
    "autoscaling:EC2_INSTANCE_LAUNCH",
    "autoscaling:EC2_INSTANCE_TERMINATE",
    "autoscaling:EC2_INSTANCE_LAUNCH_ERROR",
    "autoscaling:EC2_INSTANCE_TERMINATE_ERROR",
  ]

  topic_arn = aws_sns_topic.user-updates.arn
}

# Create an Auto Scaling Group Scale Up Policy
# terraform aws auto scaling policy
resource "aws_autoscaling_policy" "webserver-scale-up-policy" {
  name                   = "Scale Up Policy"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 60
  autoscaling_group_name = aws_autoscaling_group.auto-scaling-group.name
}

# Create a Metric Alarm for Auto Scaling Group Scale Up Policy 
# terraform aws cloudwatch meric alarm
resource "aws_cloudwatch_metric_alarm" "scale-up-alarm" {
  alarm_name          = "High CPU Alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = "90"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.auto-scaling-group.name
  }

  alarm_description = "Scale up if ec2 cpu utilization > 90% for 10 minutes"
  alarm_actions     = [aws_autoscaling_policy.webserver-scale-up-policy.arn]
}

# Create an Auto Scaling Group Scale Down Policy 
# terraform aws auto scaling policy
resource "aws_autoscaling_policy" "webserver-scale-down-policy" {
  name                   = "Scale Down Policy"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 60
  autoscaling_group_name = aws_autoscaling_group.auto-scaling-group.name
}

# Create a Metric Alarm for Auto Scaling Group Scale Down Policy 
# terraform aws cloudwatch meric alarm
resource "aws_cloudwatch_metric_alarm" "scale-down-alarm" {
  alarm_name          = "Low CPU Alarm"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = "30"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.auto-scaling-group.name
  }

  alarm_description = "Scale-down if ec2 cpu utilization < 30% for 10 minutes"
  alarm_actions     = [aws_autoscaling_policy.webserver-scale-down-policy.arn]
}