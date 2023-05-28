data "aws_partition" "default" {}

data "aws_region" "default" {}

data "aws_caller_identity" "default" {}

data "aws_organizations_organization" "default" {}

data "aws_iam_roles" "roles" {
  for_each = {
    for permissionset in var.aws_sso_permission_sets : permissionset => permissionset
  }

  name_regex  = "AWSReservedSSO_${each.key}_.*"
  path_prefix = "/aws-reserved/sso.amazonaws.com/"
}

data "aws_organizations_organizational_units" "default" {
  count = data.aws_organizations_organization.default.roots != null ? 1 : 0

  parent_id = data.aws_organizations_organization.default.roots[0].id
}
