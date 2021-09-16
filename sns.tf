# Create an SNS Topic
# terraform aws create sns topic
resource "aws_sns_topic" "user-updates" {
  name      = "User-Updates-Topic"
}

# Create an SNS Topic Subscription
# terraform aws sns topic subscription
resource "aws_sns_topic_subscription" "notification-topic" {
  topic_arn = aws_sns_topic.user-updates.arn
  protocol  = "email"
  endpoint  = "${var.operator-email}"
}