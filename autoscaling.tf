#Create an Auto Scaling Group with a placement group, lifecycle hook, and tags
resource "aws_autoscaling_group" "bar" {
  name                      = "autoscaling-group"
  max_size                  = 4
  min_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 4
  force_delete              = true

  vpc_zone_identifier = [
    aws_subnet.az1.id,
    aws_subnet.az2.id,
    aws_subnet.az3.id,
    aws_subnet.az4.id
  ]


  #Attach the launch template to the Auto Scaling Group
  launch_template {
    id      = aws_launch_template.launch_template.id
    version = "$Latest"
  }

  #Attach the target group to the Auto Scaling Group
  target_group_arns = [
    aws_lb_target_group.alb_test.arn
  ]
# The instance refresh block is used to specify the instance refresh strategy and preferences for the Auto Scaling Group. In this case, we are using a rolling update strategy with a minimum healthy percentage of 50% and an instance warmup time of 300 seconds. The triggers block specifies that the instance refresh should be triggered when the launch template is updated. This means that if we update the launch template (for example, by changing the user_data script), the Auto Scaling Group will perform a rolling update of the instances to apply the changes. The rolling update strategy will ensure that at least 50% of the instances are healthy and serving traffic during the update process, and the instance warmup time will give new instances time to initialize and become healthy before they are added to the load balancer.

instance_refresh {
  strategy = "Rolling"
  preferences {
    min_healthy_percentage = 50
    instance_warmup          = 300
  }

  triggers = ["launch_template"]
}
  tag {
    key                 = "Name"
    value               = "autoscaling-instance"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_lifecycle_hook" "terminate_hook" {
  name                   = "autoscaling-lifecycle-hook"
  autoscaling_group_name = aws_autoscaling_group.bar.name
  default_result         = "CONTINUE"
  heartbeat_timeout      = 300
  lifecycle_transition   = "autoscaling:EC2_INSTANCE_TERMINATING"
}
