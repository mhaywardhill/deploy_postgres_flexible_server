variable project_name {}

variable location {}

variable environment_name {
	default = "test"
}

variable vm_username {}

variable my_public_ip {}

variable db_username {
  description = "Username"
  type        = string
  sensitive   = true
}

variable db_password {
  description = "Password"
  type        = string
  sensitive   = true
}
