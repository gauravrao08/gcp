resource "google_service_account" "myaccount" {
  account_id   = var.service_account_name
  display_name = var.display_name
  description  = var.description
  project      = var.project_id
}

/*resource "google_service_account_key" "mykey" {
  service_account_id = google_service_account.myaccount.name
}

resource "local_file" "myaccountjson" {
    content     = base64decode(google_service_account_key.mykey.private_key)
    filename = var.secretfile
}
*/

resource "google_project_iam_member" "iam-serviceaccount" {
  project = var.project_id
  role    = var.role_access[count.index]
  count = length(var.role_access)
  member  = "serviceAccount:${google_service_account.myaccount.account_id}@${var.project_id}.iam.gserviceaccount.com"
}


