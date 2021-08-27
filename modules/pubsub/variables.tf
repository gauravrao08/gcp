variable "project_id" {
  type        = string
  description = "Project id where service account will be created."
  default     = "sm-scl-eng"
}


variable "schema_name" {
  type        = string
  description = "schema_name"
  default     = "bva-schema"
}

variable "schema_type" {
  type        = string
  description = "schema_type"
  default     = "AVRO"
}

variable "topic_name" {
  type        = list
  description = "pub/sub topci name"
  default     = [""]
}


