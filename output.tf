############################################################
# Output for VPC                                           #
############################################################

# VPC ID
output "vpc-id" {
  value     = aws_vpc.vpc.id
}

# Public Subnet 1 ID
output "public-subnet-1-id" {
  value     = aws_subnet.public-subnet-1.id
}

# Public Subnet 2 ID
output "public-subnet-2-id" {
  value     = aws_subnet.public-subnet-2.id
}

# Private Subnet 1 ID
output "private-subnet-1-id" {
  value     = aws_subnet.private-subnet-1.id
}

# Private Subnet 2 ID
output "private-subnet-2-id" {
  value     = aws_subnet.private-subnet-2.id
}

# Private Subnet 3 ID
output "private-subnet-3-id" {
  value     = aws_subnet.private-subnet-3.id
}

# Private Subnet 4 ID
output "private-subnet-4-id" {
  value     = aws_subnet.private-subnet-4.id
}

############################################################
# Output for Security Group                                #
############################################################

# Application Load Balancer Security Group ID
output "alb-security-group-id" {
  value     = aws_security_group.alb-security-group.id
}

# SSH Security Group ID
output "ssh-security-group-id" {
  value     = aws_security_group.ssh-security-group.id
}

# Web Server Security Group ID
output "webserver-security-group-id" {
  value     = aws_security_group.webserver-security-group.id
}

# Database Security Group ID
output "database-security-group-id" {
  value     = aws_security_group.database-security-group.id
}

############################################################
# Output for Database                                      #
############################################################

# Database Endpoint
output "database-instance-endpoint" {
  value     = aws_db_instance.database-instance.endpoint
}

############################################################
# Output for Application Load Balancer                     #
############################################################

# Target Group ARN
output "alb-target-group-arn" {
  value     = aws_lb_target_group.alb-target-group.arn 
}

# Application Load Balancer DNS Name
output "application-load-balancer-dns-name" {
  value     = aws_lb.application-load-balancer.dns_name 
}

# Application Load Balancer Zone ID
output "application-load-balancer-zone-id" {
  value     = aws_lb.application-load-balancer.zone_id
}

############################################################
# Output for Route 53                                      #
############################################################

# Website URL
output "website-url" {
  value     = join ("", ["https://www.", "${var.domain-name}"])
}