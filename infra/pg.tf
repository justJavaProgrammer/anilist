
data "google_compute_network" "default" {
  name = "default"
}

data "google_compute_subnetwork" "default" {
  name = "default"
}

resource "google_sql_database_instance" "postgres" {
  name                = "anime"
  database_version    = "POSTGRES_15"
  region              = "us-west1"
  deletion_protection = false

  depends_on = [data.google_compute_network.default]

  settings {
    tier = "db-f1-micro"

    user_labels = {
      "environment" = "development"
    }

    ip_configuration {
      ipv4_enabled = false
      private_network = data.google_compute_network.default.id
    }
  }
}


resource "google_sql_database" "database" {
  name     = "animedb"
  instance = google_sql_database_instance.postgres.name
}