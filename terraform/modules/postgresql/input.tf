variable location {}
variable resource_group {}
variable server_name {}
variable db_username {}
variable db_password {}
variable project {}
variable delegated_subnet_id {}
variable private_dns_zone_id {}
variable log_analytics_workspace_id {}

variable server_parameters {
  type = list(object({
    key          = string
    value        = string
  }))
  default = [
    {
      key          = "log_line_prefix"
      value        =  "%m-%p-%l-%u-%d-%a-%h-"
    }
  ]
}
