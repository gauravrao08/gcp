resource "google_pubsub_subscription" "subscription-name" {
  name  = "${element(var.topic_name, count.index)}-annonymizer"
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
}

