variable "private_subnet" {
  type = list(string)
}

variable "public_subnet" {
  type = string
}

variable "name_prefix" {
  type = string
}

variable "vpc_id" {
  type = string
}
