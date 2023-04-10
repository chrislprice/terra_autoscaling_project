#Creates Apache Security Group To Allow SSH and HTTP connectivity
module "apache-sg" {
  source = "./modules"
}

#Create ASG Launch Templaate 
resource "aws_launch_template" "asg_apache_terra_template" {
  name        = var.asg_apache_webserver_name
  image_id          = var.ami_id
  instance_type     = var.instance_type
  key_name   = var.key_pair_name
  vpc_security_group_ids = [aws_security_group.apache-terra-sg.id]
  user_data = filebase64("${path.root}/apache-installation-script.sh")
}

resource "aws_autoscaling_group" "asg_terra_created_apache_group" {
  name = "asg_terra_apache_group"
  min_size = 2
  max_size = 5
  desired_capacity = 2
  availability_zones = var.availability_zones
  launch_template {
    id = aws_launch_template.asg_apache_terra_template.id
  }
}
