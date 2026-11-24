resource "aws_elb" "terra_elb" {
  name = "terra-elb"
  subnets = aws_subnet.public_subnet.*.id
  security_groups = [aws_security_group.terra-sg.id]

  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }

  #Load balancer sends http request to /index.html on port 80 of each instances every 30 seconds
  #It expects HTTP 200 ok response within 3 seconds. If two consecutive health checks fail, the instance marked as OutOfService
  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    target = "HTTP:80/index.html"
    interval = 30
  }

  instances = [aws_instance.webservers[0].id, aws_instance.webservers[1].id]
  cross_zone_load_balancing = true
  idle_timeout = 100
  connection_draining = true
  connection_draining_timeout = 300

  tags = {
    Name = "terra-lb"
  }
}

output "elb-dns-name" {
  value = aws_elb.terra_elb.dns_name
}