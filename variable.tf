# VPC Variables
variable "region" {
  default       = "us-east-1"
  description   = "AWS Region"
  type          = string
}

variable "vpc-cidr" {
  default       = "10.0.0.0/16"
  description   = "VPC CIDR Block"
  type          = string
}

variable "public-subnet-1-cidr" {
  default       = "10.0.0.0/24"
  description   = "Public Subnet 1 CIDR Block"
  type          = string
}

variable "public-subnet-2-cidr" {
  default       = "10.0.1.0/24"
  description   = "Public Subnet 2 CIDR Block"
  type          = string
}

variable "private-subnet-1-cidr" {
  default       = "10.0.2.0/24"
  description   = "Private Subnet 1 CIDR Block"
  type          = string
}

variable "private-subnet-2-cidr" {
  default       = "10.0.3.0/24"
  description   = "Private Subnet 2 CIDR Block"
  type          = string
}

variable "private-subnet-3-cidr" {
  default       = "10.0.4.0/24"
  description   = "Private Subnet 3 CIDR Block"
  type          = string
}

variable "private-subnet-4-cidr" {
  default       = "10.0.5.0/24"
  description   = "Private Subnet 4 CIDR Block"
  type          = string
}

# Security Group Variables
variable "ssh-location" {
  default       = "0.0.0.0/0"
  description   = "IP Address That Can SSH Into the EC2 Instances"
  type          = string
}

# RDS Variables
variable "database-instance-class" {
  default       = "db.t2.micro"
  description   = "The Database Instance Type"
  type          = string
}

variable "database-instance-identifier" {
  default       = "dammytestclouddb"
  description   = "The Database Instance Identifier"
  type          = string
}

variable "database-snapshot-identifier" {
  default       = "arn:aws:rds:us-east-1:431419854259:snapshot:dammytestclouddb-final-snapshot"
  description   = "The Database Snapshot ARN"
  type          = string
}

variable "multi-az-deployment" {
  default       = false
  description   = "Create a Standby DB Instance"
  type          = bool
}

# Application Load Balancer Variables
variable "ssl-certificate-arn" {
  default       = "arn:aws:acm:us-east-1:431419854259:certificate/329a11ce-15ad-4cfe-9dd2-9160b8818676"
  description   = "SSL Certificate Arn"
  type          = string
}

# SNS Topic Variables
variable "operator-email" {
  default       = "ajiboladamola789@gmail.com"
  description   = "A Valid Email Address"
  type          = string
}

# Auto Scaling Group Variables
variable "launch-template-name" {
  default       = "Server-Launch-Template"
  description   = "Name of Launch Template"
  type          = string
}

variable "ec2-image-id" {
  default       = "ami-033c7c643b76f467b"
  description   = "The ID of the AMI"
  type          = string
}

variable "ec2-instance-type" {
  default       = "t2.micro"
  description   = "The Instance Type for the EC2 Instance"
  type          = string
}

variable "ec2-key-pair-name" {
  default       = "myec2key"
  description   = "Name of an EC2 Key Pair"
  type          = string
}

# Route 53 Variables
variable "domain-name" {
  default       = "arteryventure.com"
  description   = "The Domain Name"
  type          = string
}
