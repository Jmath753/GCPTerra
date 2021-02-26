provider "google" {
  credentials = "${file("test-30068-3f3a632a12cf.json")}"
  project     = "test-30068"
  region      = "us-central1"
  zone        = "us-central1-c"
}