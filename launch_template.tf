data "aws_ami" "ami_name" {
  most_recent = true
  owners      = ["self"]

  filter {
    name   = "name"
    values = ["TestAMI"]
  }
}
resource "aws_launch_template" "terra_lt" {
  name_prefix = "terra-launch-template-"
  image_id = data.aws_ami.ami_name.id
  instance_type = var.instance_type
  key_name = var.key_name

  vpc_security_group_ids = [aws_security_group.terra-sg.id]

  user_data              = filebase64("install_httpd.sh")

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "terra-asg-webserver"
      Env = "dev"
    }
  }
}