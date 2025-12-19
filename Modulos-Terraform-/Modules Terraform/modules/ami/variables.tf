variable "name_prefix" {
  type = string
}

variable "instance_type" {
    type = string
}

variable "key_name" {
  type = string
}

variable "user_data" {
    type = string
}

variable "security_group_id" {
  type = list(string)
}

variable "volume_size" {
  type = number
}

variable "volume_type" {
  type = string
}

variable "delete" {
  type = bool
}

variable "public_ip" {
    type = bool
}