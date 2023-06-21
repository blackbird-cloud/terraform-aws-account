variable "aws_sso_permission_sets" {
  type        = list(string)
  default     = []
  description = "(Optional) List of permission-set names for which to retrieve the IAM roles."
}
