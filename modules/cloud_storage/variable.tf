variable "bucket_name"{
  type        = string
  description = "bucket_name"
  default     = ""
}

variable "bucket_region"{
  type        = string
  description = "bucket_region"
  default     = ""
}
variable "project_id"{
  type        = string
  description = "project_id"
  default     = ""
}
variable "service_account"{
  type        = string
  description = "service_account"
  default     = ""
}

variable "bucket_role"{
  type        = list
  description = "bucket_role"
  default     = [""]
}
