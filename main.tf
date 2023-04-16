#Creates Apache Security Group via the module
module "apache-sg" {
  source = "./modules"
}

#Create Auto Scaling template that'll be used to create the EC2 instances
resource "aws_launch_template" "asg_apache_terra_template" {
  name                   = var.asg_apache_webserver_name #Define the name of the template
  image_id               = var.ami_id #Define the AMI to be used for the EC2 instance
  instance_type          = var.instance_type #Define the instance type to be used when creating the instance
  key_name               = var.key_pair_name #Define the key pair that'll be used to connect to the server via SSH
  vpc_security_group_ids = [module.apache-sg.sgid] #Uses the Security Group module output value "sgid" to set the vpc_security_group_ids parameter
  user_data = filebase64("${path.root}/apache-installation-script.sh") #Informs Terraform the location of the Apache installation script. This will install Apache on the EC2 during setup.
}

#Create Auto Scaling Group named "asg_terra_apache_group". The group will be greated with 2 servers and a maximum of 5
resource "aws_autoscaling_group" "asg_terra_created_apache_group" {
  name               = "asg_terra_apache_group"
  min_size           = 2
  max_size           = 5
  desired_capacity   = 2
  availability_zones = var.availability_zones #Defines which availability zones to create the EC2 servers in
  launch_template {
    id = aws_launch_template.asg_apache_terra_template.id #Sets launch template ID to be the value of resource asg_apache_terra_template created above
  }
}
