# resource "aws_instance" "webservers" {
#   count                  = length(var.public_subnet_cidr_block)
#   ami                    = data.aws_ami.ami_name.id
#   instance_type          = var.instance_type
#   vpc_security_group_ids = [aws_security_group.terra-sg.id]
#   subnet_id              = element(aws_subnet.public_subnet.*.id, count.index)
#   key_name               = var.key_name
#   #user_data              = file("install_httpd.sh")
#   tags = {
#     Name = "web-server-terra-${count.index + 1}"
#     Env  = "dev"
#   }
# }

# resource "aws_instance" "dbservers" {
#   count                  = length(var.private_subnet_cidr_block)
#   ami                    = data.aws_ami.ami_name.id
#   instance_type          = var.instance_type
#   vpc_security_group_ids = [aws_security_group.terra-sg.id]
#   subnet_id              = element(aws_subnet.private_subnet.*.id, count.index)
#   key_name               = var.key_name
#   tags = {
#     Name = "db-server-terra-${count.index + 1}"
#     Env  = "dev"
#   }
# }