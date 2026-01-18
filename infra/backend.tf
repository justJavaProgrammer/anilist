terraform {
  backend "gcs" {
    bucket  = "anilist-tf-state-prod"
    prefix  = "terraform/state"
  }
}