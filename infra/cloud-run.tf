resource "google_cloud_run_v2_service" "default" {
  name     = "cloudrun-srv"
  location = "us-west1"
  deletion_protection = false
  ingress = "INGRESS_TRAFFIC_ALL"

  scaling {
    max_instance_count=1
  }

  template {
      containers {
        image = "us-docker.pkg.dev/cloudrun/container/hello"
        resources {
          limits = {
            memory: "512Mi",
            "cpu": "1"
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