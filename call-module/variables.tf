variable "region" {
  type        = string
  description = "region name"
  default     = "us-east1"
}

variable "project_id"{
  type        = string
  description = "project_id"
  default     = ""
}

variable "repo_path_input"{
  type        = string
  description = "repo_path_input"
  default     = ""
}

variable "topic_name" {
  type        = list
  description = "topic_name"
  default     = ["topic-asia-southeast1","topic-us-west1", "topic-europe-west1"]
}

variable "raw_bucket_name_one" {
  type        = string
  description = "bucket_name_one"
  default     = ""
}

variable "raw_bucket_region_one" {
  type        = string
  description = "bucket_region_one"
  default     = ""
}
variable "cf_project_id" {
  type        = string
  description = "cf_project_id"
  default     = ""
}

variable "cf_input_name_one" {
  type        = string
  description = "cf_input_name_one"
  default     = ""
}

variable "cf_input_region_one" {
  type        = string
  description = "cf_input_region_one"
  default     = ""
}


