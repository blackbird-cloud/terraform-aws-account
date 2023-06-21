output "account_id" {
  value       = data.aws_caller_identity.default.account_id
  description = "The account's account id."
}

output "partition" {
  value       = data.aws_partition.default.id
  description = "The account's partition."
}

output "region" {
  value       = data.aws_region.default.name
  description = "The current region."
}

output "organization" {
  value       = data.aws_organizations_organization.default
  description = "The account's organization."
}

output "organizational_units" {
  value       = try(data.aws_organizations_organizational_units.default[0], null)
  description = "The account's organizational units. Is empty on non management-account."
}

output "sso_roles" {
  value = {
    for permissionset, role in data.aws_iam_roles.roles : permissionset => {
      arn : [for arn in role.arns : arn][0],
      name : [for name in role.names : name][0],
      arn_no_path : "arn:aws:iam::${data.aws_caller_identity.default.account_id}:role/${[for name in role.names : name][0]}"
    }
  }
  description = "The roles created by the IAM Identity Center, configure the variable `aws_sso_permission_sets` when you want to retrieve these."
}
