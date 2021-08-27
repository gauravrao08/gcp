resource "google_storage_bucket" "bucket" {
  name     = var.bucket_name
  location = var.bucket_region
  project = var.project_id
  #depends_on = [google_service_account.myaccount]
  depends_on = [var.service_account]
}

resource "google_storage_bucket_iam_member" "binding" {
  bucket = google_storage_bucket.bucket.name
  role = var.bucket_role[count.index]
  count = length(var.bucket_role)
  member = "serviceAccount:${var.service_account}"
  depends_on = [google_storage_bucket.bucket]
}
