# Create Cloud Function
resource "google_cloudfunctions_function" "inputfunction" {
  name    = var.function_name
  runtime = "python39" # Switch to a different runtime if needed
  region = var.cf_region
  available_memory_mb = 128
  #source_archive_bucket = google_storage_bucket.temp-bucket.name
  source_archive_bucket = "gaurav-delete-input-cf-bucket-1"
  #source_archive_object = google_storage_bucket_object.zip.name
  source_archive_object = "source.zip"
  entry_point      = var.function_entry_point
  ingress_settings = "ALLOW_INTERNAL_ONLY"
  event_trigger {
    event_type = "google.storage.object.finalize"
    resource   = var.bucket_name
 ##this bucket name need to be update with raw bcuket name
  }
  environment_variables = var.environment_variables
  service_account_email = var.service_account
}

