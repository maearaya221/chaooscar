output "load_balancer_arn" {
  value = aws_lb.load_balancer_app.arn
}

output "dns_lb" {
  value = aws_lb.load_balancer_app.dns_name
}