terraform {
  required_version = ">= 1.0"
}

resource "aws_security_group" "web_sg" {
  name        = "devsecops-lab-web"
  description = "Security group for web workload"

  ingress {
    description = "SSH from approved company IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Public HTTP access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "HTTPS outbound traffic"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["203.0.113.10/32"]
  }
}
