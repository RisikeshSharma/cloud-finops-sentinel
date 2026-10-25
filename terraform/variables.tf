variable "environment" {
  description = "Target deployment environment."
  type        = string
  default     = "prod"
}

variable "location" {
  description = "Azure region."
  type        = string
  default     = "eastus"
}

variable "app_name" {
  description = "Application base name."
  type        = string
  default     = "finops-sentinel"
}

variable "scan_schedules" {
  description = "Map of automated waste scans with cron expressions iterated via for_each."
  type = map(object({
    cron_expression = string
    severity        = string
  }))
  default = {
    "unattached_disks" = {
      cron_expression = "0 0 * * *"
      severity        = "HIGH"
    }
    "orphan_public_ips" = {
      cron_expression = "0 */6 * * *"
      severity        = "MEDIUM"
    }
    "underutilized_vms" = {
      cron_expression = "0 2 * * 1"
      severity        = "MEDIUM"
    }
  }
}

variable "custom_app_settings" {
  description = "Dynamic app settings for Azure Function App."
  type        = map(string)
  default = {
    "FINOPS_SAVINGS_TARGET_PCT" = "30"
    "AUTO_DRAIN_NONPROD_ENABLED" = "true"
    "INVENTORY_RETENTION_DAYS"   = "90"
  }
}

variable "enable_budget_alert_gate" {
  description = "Conditional iteration flag for Infracost PR budget enforcement."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Resource tags."
  type        = map(string)
  default = {
    Architecture = "Serverless-FinOps-Sentinel"
    ManagedBy    = "Terraform"
    Owner        = "Rishikesh Sharma"
  }
}
