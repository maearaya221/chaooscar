variable "name" {
    type = string
}

variable "internal" {
    type = bool
}

variable "load_balancer_type" {
    type = string
}

variable "security_groups" {
    type = list(string)
}

variable "subnets" {
    type = list(string)
}

variable "tag_name" {
    type = string
}
