resource "google_pubsub_topic" "animes" {
  name = "new-animes"

  message_retention_duration = "86600s"
}

resource "google_pubsub_topic" "animes-dlq" {
  name = "animes-dlq"
  message_retention_duration = "604800s"

}

resource "google_pubsub_subscription" "created" {
  name  = "created"
  topic = google_pubsub_topic.animes.id

  ack_deadline_seconds = 20
  retain_acked_messages = false

  retry_policy {
    minimum_backoff = "10s"
  }

  dead_letter_policy {
    dead_letter_topic = google_pubsub_topic.animes-dlq.id
    max_delivery_attempts = 10
  }
}