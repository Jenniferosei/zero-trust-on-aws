provider "aws" {
  region = var.region
}

resource "aws_vpc" "zero_trust" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "zero-trust-vpc"
  }
}

resource "aws_subnet" "public" {
  count                   = 2
  vpc_id                  = aws_vpc.zero_trust.id
  cidr_block              = cidrsubnet(aws_vpc.zero_trust.cidr_block, 8, count.index)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-${count.index}"
  }
}

resource "aws_network_acl" "zero_trust_acl" {
  vpc_id = aws_vpc.zero_trust.id
  tags = {
    Name = "zero-trust-nacl"
  }
}

resource "aws_network_acl_rule" "deny_http_inbound" {
  network_acl_id = aws_network_acl.zero_trust_acl.id
  rule_number    = 100
  egress         = false
  protocol       = "tcp"
  rule_action    = "deny"
  cidr_block     = "0.0.0.0/0"
  from_port      = 80
  to_port        = 80
}

data "aws_availability_zones" "available" {}
