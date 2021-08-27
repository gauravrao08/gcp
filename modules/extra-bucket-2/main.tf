#this bucket will be deleted auto-matically-gaurav
#this output cloud function dont change bucket name!!! please
resource "google_storage_bucket" "delete-bucket-two" {
  name     = "gaurav-delete-cf-output-bucket-two"
  project = var.project_id
  location = "asia-southeast1"
  force_destroy = true
}

locals {
  timestamp = formatdate("YYMMDDhhmmss", timestamp())
        root_dir = abspath(var.repo_path)
}

# Compress source code
data "archive_file" "source" {
  type        = "zip"
  source_dir  = local.root_dir
  output_path = "/tmp/output-function-${local.timestamp}.zip"
}
# Add source code zip to bucket
resource "google_storage_bucket_object" "zip" {
  # Append file MD5 to force bucket to be recreated
  #name   = "source.zip#${data.archive_file.source.output_md5}"
  name   = "source_output.zip"
  bucket = google_storage_bucket.delete-bucket-two.name
  source = data.archive_file.source.output_path
}
