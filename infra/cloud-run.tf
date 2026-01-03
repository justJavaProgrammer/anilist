resource "google_cloud_run_v2_service" "default" {
  name                = "cloudrun-srv"
  location            = "us-west1"
  deletion_protection = false
  ingress             = "INGRESS_TRAFFIC_ALL"

  depends_on = [google_sql_database_instance.postgres]

  scaling {
    max_instance_count = 1
  }

  template {
    vpc_access {
      egress    = "PRIVATE_RANGES_ONLY"

      network_interfaces {
        network = data.google_compute_network.default.name
        subnetwork = data.google_compute_network.default.name
      }
    }

    containers {
      env {
        name = "DATASOURCE_USERNAME"
        value_source {
          secret_key_ref {
            secret = "db-username"
            version = "latest"
          }
        }
      }
      env {
        name = "DATASOURCE_PASSWORD"
        value_source {
          secret_key_ref {
            secret = "db-password"
            version = "latest"
          }
        }
      }

      env {
        name = "DATASOURCE_URL"
        value = "jdbc:postgresql://${google_sql_database_instance.postgres.private_ip_address}/animedb"
      }

      image = "us-west1-docker.pkg.dev/integral-zephyr-481413-k6/dev/anime-rest-api:4"

      resources {
        limits = {
          memory : "512Mi",
          "cpu" : "1"
        }
      }
    }
  }
}

resource "google_cloud_run_v2_service_iam_member" "public" {
  name     = google_cloud_run_v2_service.default.name
  location = google_cloud_run_v2_service.default.location
  role     = "roles/run.invoker"
  member   = "allUsers"
}
