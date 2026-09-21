terraform {
  required_version = ">= 1.10.0, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region  = var.aws_region
  profile = "personal"

  default_tags {
    tags = {
      Project     = "track-2-secure-zero-touch-edge"
      Environment = "poc"
      ManagedBy   = "terraform"
    }
  }
}

variable "aws_region" {
  description = "AWS region for the Phase 0 control-plane host."
  type        = string
  default     = "ap-south-1"
}

variable "availability_zone" {
  description = "Optional AZ. Leave null to let AWS select from the region."
  type        = string
  default     = null
}

variable "admin_cidr" {
  description = "Administrator public IPv4 CIDR allowed to SSH, for example 203.0.113.10/32."
  type        = string

  validation {
    condition     = can(cidrnetmask(var.admin_cidr)) && var.admin_cidr != "0.0.0.0/0"
    error_message = "admin_cidr must be a valid restricted CIDR; 0.0.0.0/0 is forbidden."
  }
}

variable "edge_https_cidrs" {
  description = "IPv4 CIDRs allowed to reach HTTPS. Phase 0 may use 0.0.0.0/0; restrict later."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "ssh_public_key_path" {
  description = "Local path to the administrator OpenSSH public key."
  type        = string
  default     = "~/.ssh/id_ed25519.pub"
}

variable "instance_type" {
  description = "EC2 instance type for the PoC host."
  type        = string
  default     = "t3.medium"
}

variable "root_volume_size_gib" {
  description = "Root gp3 volume size in GiB."
  type        = number
  default     = 60
}

data "aws_ssm_parameter" "ubuntu_2404_ami" {
  name = "/aws/service/canonical/ubuntu/server/24.04/stable/current/amd64/hvm/ebs-gp3/ami-id"
}

resource "aws_vpc" "poc" {
  cidr_block           = "10.20.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = { Name = "track-2-poc-vpc" }
}

resource "aws_internet_gateway" "poc" {
  vpc_id = aws_vpc.poc.id
  tags   = { Name = "track-2-poc-igw" }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.poc.id
  cidr_block              = "10.20.10.0/24"
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = false

  tags = { Name = "track-2-poc-public" }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.poc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.poc.id
  }

  tags = { Name = "track-2-poc-public" }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_security_group" "control" {
  name        = "track-2-poc-control"
  description = "Phase 0: restricted SSH and public HTTPS only"
  vpc_id      = aws_vpc.poc.id

  ingress {
    description = "SSH from administrator"
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = [var.admin_cidr]
  }

  ingress {
    description = "HTTPS from edge networks"
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = var.edge_https_cidrs
  }

  egress {
    description = "Required for package downloads and outbound service calls"
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "track-2-poc-control" }
}

resource "aws_key_pair" "admin" {
  key_name   = "track-2-poc-admin"
  public_key = file(pathexpand(var.ssh_public_key_path))
}

resource "aws_iam_role" "ssm" {
  name = "track-2-poc-ssm-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ssm" {
  role       = aws_iam_role.ssm.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "ssm" {
  name = "track-2-poc-ssm-profile"
  role = aws_iam_role.ssm.name
}

resource "aws_instance" "control" {
  ami                         = data.aws_ssm_parameter.ubuntu_2404_ami.value
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.control.id]
  key_name                    = aws_key_pair.admin.key_name
  iam_instance_profile        = aws_iam_instance_profile.ssm.name
  associate_public_ip_address = false
  monitoring                  = true

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
    instance_metadata_tags      = "disabled"
  }

  root_block_device {
    volume_type           = "gp3"
    volume_size           = var.root_volume_size_gib
    encrypted             = true
    delete_on_termination = true
  }

  user_data = <<-CLOUD_INIT
    #cloud-config
    package_update: true
    package_upgrade: true
    packages:
      - ca-certificates
      - curl
      - docker.io
      - git
      - jq
      - openssl
      - unzip
    runcmd:
      - [systemctl, enable, --now, docker]
      - [usermod, -aG, docker, ubuntu]
      - [mkdir, -p, /opt/track-2-poc]
      - [chown, ubuntu:ubuntu, /opt/track-2-poc]
      - [docker, run, --rm, hello-world]
  CLOUD_INIT

  lifecycle {
    precondition {
      condition     = var.root_volume_size_gib >= 40
      error_message = "The Phase 0 root volume must be at least 40 GiB."
    }
  }

  tags = { Name = "track-2-poc-control" }
}

resource "aws_eip" "control" {
  domain   = "vpc"
  instance = aws_instance.control.id

  depends_on = [aws_internet_gateway.poc]
  tags       = { Name = "track-2-poc-control" }
}

output "control_public_ip" {
  description = "Elastic IP. Treat it as environment data; do not commit it to Git."
  value       = aws_eip.control.public_ip
}

output "control_public_dns" {
  value = aws_instance.control.public_dns
}

output "ssh_command" {
  value = "ssh ubuntu@${aws_eip.control.public_ip}"
}

output "ssm_start_session_command" {
  value = "aws --profile personal --region ${var.aws_region} ssm start-session --target ${aws_instance.control.id}"
}
