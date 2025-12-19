resource "aws_autoscaling_group" "auto_scaling" {
    name = var.name
    min_size = var.min_size
    max_size = var.max_size
    desired_capacity = var.desired_capacity
    launch_template {
      id = var.plantilla_id
      version = var.launch_template_version
    }

    vpc_zone_identifier = var.subnet_zone_id
}

resource "aws_autoscaling_attachment" "assoc_autoscal_target_group" {
    autoscaling_group_name = aws_autoscaling_group.auto_scaling.id
    lb_target_group_arn = var.target_group_arn
}