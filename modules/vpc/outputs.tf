output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_id" {
  value = aws_subnet.pub_sub_1[*].id
}
output "private_subnet_id" {
  value = aws_subnet.priv_sub_1[*].id
}