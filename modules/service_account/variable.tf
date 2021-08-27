variable "project_id" {
  type        = string
  description = "Project id where service account will be created."
  default     = "sm-scl-eng"
}
  
variable "display_name"{
  type        = string
  description = "service account name"
  default     = "bva sa cloud function"
}

variable "description"{
  type        = string
  description = "service account"
  default     = "bva sa cloud function"
}

variable "service_account_name" {
  type        = string
  description = "service account name"
  default     = "bva-account-id"
}

variable "role_access" {
  type        = list
  description = "service account role"
  default     = [""]
}

