resource "aws_autoscaling_group" "aws_ag" {
  name = "terra-auto-scalling-group"

  min_size         = 2
  max_size         = 4
  desired_capacity = 2

  vpc_zone_identifier = aws_subnet.public_subnet[*].id

  launch_template {
    id      = aws_launch_template.terra_lt.id
    version = "$Latest"
  }

  load_balancers = [aws_elb.terra_elb.name]

  health_check_type         = "ELB"
  health_check_grace_period = 300

  tag {
    key                 = "Name"
    value               = "terra-asg-webserver"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_policy" "cpu_scalling" {
  name = "terra-cpu-scalling"
  autoscaling_group_name = aws_autoscaling_group.aws_ag.name
  policy_type = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    #Attempts to maintain average CPU utilization around 5%. If it goes beyond this value, intances will launch automatically
    target_value = "5.0"
  }
}