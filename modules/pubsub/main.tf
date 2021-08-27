
resource "google_pubsub_topic" "topic" {
  name = var.topic_name[count.index]
  project = var.project_id
  count = length(var.topic_name)
#  schema_settings {
#    schema = "projects/${var.project_id}/schemas/${var.schema_name}"
#    encoding = "JSON"
#  }
}
/*
resource "google_pubsub_subscription" "subscription-name" {
  #name  = "${google_pubsub_topic.topic.name}-sub"
  name  = "${element(var.topic_name, count.index)}-anonymizer"
  #topic = google_pubsub_topic.topic.name
  topic = element(var.topic_name, count.index)
  count = length(var.topic_name)
  labels = {
    group = "scl"
  }

  # 7 days
  message_retention_duration = "604800s"
  retain_acked_messages      = false

  ack_deadline_seconds = 10

  expiration_policy {
    ttl = ""
  }
  retry_policy {
    minimum_backoff = "10s"
    maximum_backoff = "600s"
  }

  enable_message_ordering    = false
}*/
