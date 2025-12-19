resource "aws_subnet" "public" {
    count = length(var.public_subnet)
    vpc_id = var.vpc_id
    cidr_block = var.public_subnet[count.index]
    availability_zone = var.availability_zones[count.index]
    map_public_ip_on_launch = true
    tags = {
      Name = "${var.name_prefix}-public-${count.index}"
    }

}

resource "aws_subnet" "private" {
    count = length(var.private_subnet)
    vpc_id = var.vpc_id
    cidr_block = var.private_subnet[count.index]
    availability_zone = var.availability_zones[count.index]
    tags = {
      Name = "${var.name_prefix}-private-${count.index}"
    }
}

