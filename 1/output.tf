output "show_vpcs" {
  value = data.aws_vpcs.show_vpcs.ids
}

output "show_subnets" {
  value = data.aws_subnets.show_subnets.ids
}

output "show_sg" {
  value = data.aws_security_groups.show_sg.ids
}
