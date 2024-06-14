provider "aws" {
  region = var.region
}
resource "aws_instance" "JenkinsServer" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  subnet_id       = var.subnet_id
  security_groups = [aws_security_group.ec2-sec-gr.id]
  user_data       = base64decode(local.user_data)
  key_name        = var.key_name
  tags            = var.tags
}

data "aws_vpc" "default" {
  default = true
}

resource "aws_security_group" "ec2-sec-gr" {
  name        = var.security_group_name
  description = "EC2-sec-gr"
  vpc_id      = data.aws_vpc.default.id
  tags        = var.tags
  dynamic "ingress" {
    for_each = var.ports
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }
  dynamic "ingress" {
    for_each = var.ssh_ports
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

locals {
  user_data = <<EOF
  
  #!/bin/bash
  sudo yum update -y
  sudo amazon-linux-extras install java-openjdk11 -y
  wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
  rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key
  sudo yum install jenkins -y
  sudo systemctl start jenkins
  sudo systemctl enable jenkins
  sudo firewall-cmd --permanent --zone=public --add-port=8080/tcp
  sudo firewall-cmd --reload
  echo "Jenkins setup complete" >> ~/user-data.txt
EOF
}
