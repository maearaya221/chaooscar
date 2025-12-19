variable "name" {
  type = string
}

variable "port" {
  type = number
}

variable "protocol" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "protocol_health" {
  type = string
}

variable "path" {
  type = string
}

variable "interval" {
  type = number
}

variable "timeout" {
  type = number
}

variable "healthy_threshold" {
  type = number
}

variable "unhealthy_threshold" {
  type = number
}