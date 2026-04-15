output "s3_bucket_name" {
  value = aws_s3_bucket.test_bucket.id
}

output "load_balancer_dns_name" {
  value = aws_lb.alb_test.dns_name
}

output "autoscaling_group_name" {
  value = aws_autoscaling_group.bar.name
}

output "target_group_name" {
  value = aws_lb_target_group.alb_test.name
}