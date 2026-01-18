resource "google_cloud_run_v2_service" "anilist" {
  name                = "anilist"
  location            = "us-west1"
  deletion_protection = false
  ingress             = "INGRESS_TRAFFIC_ALL"

  scaling {
    max_instance_count = 1
  }

  template {
    vpc_access {
      egress = "PRIVATE_RANGES_ONLY"

      network_interfaces {
        network    = data.google_compute_network.default.name
        subnetwork = data.google_compute_network.default.name
      }
    }

    containers {

      # Placeholder for the image, actual image set in gcloud run deploy stage
      image = "gcr.io/cloudrun/hello"

      # Not the best, but at least we don't need to resolve the IP of the instance using external tools(gcloud)
      # Another option is not use Cloud Auth Proxy and connect via localhost, not sure what the best option is
      env {
        name = "DATASOURCE_URL"
        value = "jdbc:postgresql://${google_sql_database_instance.postgres.private_ip_address}:5432/postgres"
      }

      resources {
        limits = {
          memory : "512Mi",
          "cpu" : "1"
        }
      }
    }
  }

  lifecycle {
    ignore_changes = [
      # Application uses gcloud run deploy tool to deploy the new image revisions to the cloud,
      # so we don't need terraform to track these properties, as it is valid to be changed over the time
      client,
      client_version,
      template[0].containers[0].image,
      template[0].containers[0].env
    ]
  }
}

resource "google_cloud_run_v2_service_iam_member" "public" {
  name     = google_cloud_run_v2_service.anilist.name
  location = google_cloud_run_v2_service.anilist.location
  role     = "roles/run.invoker"
  member   = "allUsers"
}
