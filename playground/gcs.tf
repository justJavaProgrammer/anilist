resource "google_storage_bucket" "state" {
  name          = "${terraform.workspace}_anilist_arch"
  location      = "US"
  storage_class = "STANDARD"

  uniform_bucket_level_access = true
}

