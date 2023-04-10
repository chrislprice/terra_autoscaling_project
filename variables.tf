variable "aws_region" {
  type = string
  default = "us-east-1"
}

variable "vpc_id" {
  type = string
  default = "vpc-0e2f58aa9cad47756"
}

variable "availability_zones" {
  type    = list
  default = ["us-east-1a", "us-east-1b"]
}

variable "asg_apache_webserver_name" {
  type    = string
  default = "asg_apache_webserver_template"
}

variable "ami_id" {
  description = "AMI used for the webserver"
  type        = string
  default     = "ami-0fa1de1d60de6a97e"
}

variable "instance_type" {
  description = "Instance type used for webserver"
  type        = string
  default     = "t2.micro"
}

variable "key_pair_name" {
  type = string
  default = "enter key pair name"
}
