output "account_id" {
  value = data.aws_caller_identity.default.account_id
}

output "partition" {
  value = data.aws_partition.default.id
}

output "region" {
  value = data.aws_region.default.name
}

output "organization" {
  value = data.aws_organizations_organization.default
}

output "organizational_units" {
  value = data.aws_organizations_organizational_units.default
}

output "sso_roles" {
  value = {
    for permissionset, role in data.aws_iam_roles.roles : permissionset => {
      arn : [for arn in role.arns : arn][0],
      name : [for name in role.names : name][0],
      arn_no_path : "arn:aws:iam::${data.aws_caller_identity.default.account_id}:role/${[for name in role.names : name][0]}"
    }
  }
}
