variable "function_name"{
  type        = string
  description = "function_name"
  default     = ""
}
variable "cf_region"{
  type        = string
  description = "cf_region"
  default     = ""
}
variable "bucket_name"{
  type        = string
  description = "bucket_name"
  default     = ""
}
variable "project_id"{
  type        = string
  description = "project_id"
  default     = ""
}
variable "function_entry_point"{
  type        = string
  description = "function_entry_point"
  default     = ""
}
variable "environment_variables" {
  type        = map(string)
  default     = {}
  description = "A set of key/value environment variable pairs to assign to the function."
}
variable "service_account"{
  type        = string
  description = "service_account"
  default     = ""
}
