resource "aws_launch_template" "launch_template" {
  name_prefix   = "autoscaling-launch-template"
  image_id      = "ami-0c02fb55956c7d316" # Amazon Linux 2 AMI (HVM), SSD Volume Type
  instance_type = "t3.micro"

  vpc_security_group_ids = [
    aws_security_group.allow_tls.id
  ]

#user_data is used to run a script on the instance when it is launched. In this case, we are installing and starting the Apache HTTP server and creating a simple index.html file to verify that the instance is running and serving web traffic.
user_data = base64encode(<<-EOF
#!/bin/bash
yum update -y
yum install -y httpd
systemctl enable httpd
systemctl start httpd
echo "<h1>Auto Scaling Group Instance Running</h1>" > /var/www/html/index.html
EOF
)

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "autoscaling-instance"
    }
  }
}

