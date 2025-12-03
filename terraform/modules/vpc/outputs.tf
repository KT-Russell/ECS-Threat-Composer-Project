output "vpc_id" {
  description = "The VPC ID"
  value       = aws_vpc.main.id
}

output "public_subnets_ids" {
  description = "IDs of public subnets"
  value       = aws_subnet.public[*].id
}

output "internet_gateway_id" {
  description = "IGW ID"
  value       = aws_internet_gateway.igw.id
}