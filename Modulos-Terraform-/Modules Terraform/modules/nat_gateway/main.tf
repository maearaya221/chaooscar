resource "aws_eip" "nat_eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat_gw" {
    allocation_id = aws_eip.nat_eip.id
    subnet_id = var.public_subnet
    tags = {
      Name = var.name_prefix
    }
}

resource "aws_route_table" "private" {
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }
  tags = {
    Name = "${var.name_prefix}-private-rt"
    }
}

resource "aws_route_table_association" "private_subnets_assoc" {
  count = length(var.private_subnet)
  subnet_id = var.private_subnet[count.index]
  route_table_id = aws_route_table.private.id
}
