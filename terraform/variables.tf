variable "" {
  description = "prefix used for rg and server name"
  type        = string
  default     = "postgressqlflex894443"
}

variable "db_username" {
  description = "username"
  type        = string
  default     = "rzZH71kuFq"
}

variable "db_password" {
  description = "password"
  type        = string
  sensitive   = true
}