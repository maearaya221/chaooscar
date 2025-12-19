variable "name" {
  type = string
}

variable "min_size" {
  type = number
}

variable "max_size" {
  type = number
}

variable "desired_capacity" {
    type = number
}

variable "plantilla_id" {
  type = string
}

variable "launch_template_version" {
  type = string
  default = "$Latest"
}

variable "subnet_zone_id" {
  type = list(string)
}

variable "target_group_arn" {
  type = string
}