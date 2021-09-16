# Get Hosted Zone Details
# terraform aws data hosted zone
data "aws_route53_zone" "hosted-zone" {
  name = "${var.domain-name}"
}

# Create a Record Set in Route 53
# terraform aws route 53 record
resource "aws_route53_record" "site-domain" {
  zone_id = data.aws_route53_zone.hosted-zone.zone_id
  name    = join ("", ["www.", "${var.domain-name}"])
  type    = "A"

  alias {
    name                   = aws_lb.application-load-balancer.dns_name
    zone_id                = aws_lb.application-load-balancer.zone_id
    evaluate_target_health = true
  }
}