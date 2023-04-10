variable "http_port" {
  type        = number
  description = "HTTP port"
  default     = 80
}

variable "ssh_port" {
  type        = number
  description = "SSH port for connectivity"
  default     = 22
}

variable "cidr_ingress_block" {
  type    = string
  default = "0.0.0.0/0"
}

variable "vpc_id"{
  type = string
  default ="vpc-0e2f58aa9cad47756"
}

resource "aws_security_group" "apache-terra-sg" {
  name   = "apache-terra-sg"
  vpc_id = var.vpc_id

  ingress {
    description = "Allow SSH Connectiviy"
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = [var.cidr_ingress_block]
  }

  ingress {
    description = "Allow HTTP Traffic"
    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = "tcp"
    cidr_blocks = [var.cidr_ingress_block]
  }

  egress {
    description = "Allow outbound traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Terraform-Apache-SG"
  }
}


output "sgid" {
  value = aws_security_group.apache-terra-sg.id
}
