variable "location" {
  description = "Azure region for the resource group and PostgreSQL server."
  type        = string
  default     = "West Europe"
}

variable "admin_login" {
  description = "PostgreSQL administrator login name."
  type        = string
  default     = "pgadmin"
}

variable "client_ip" {
  description = <<EOT
Optional public IPv4 address that should be allowed to reach the server
(e.g. your workstation's IP). Leave empty to skip creating a firewall
rule. Look it up with `curl https://api.ipify.org` or, on PowerShell,
`(Invoke-RestMethod https://api.ipify.org).Trim()`.
EOT
  type        = string
  default     = ""

  validation {
    condition     = var.client_ip == "" || can(regex("^([0-9]{1,3}\\.){3}[0-9]{1,3}$", var.client_ip))
    error_message = "client_ip must be empty or a plain IPv4 address like 203.0.113.42."
  }
}
