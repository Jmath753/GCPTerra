provider "google" {
  credentials = "${file("test-30068-1db1593c7fd7.json")}"
  project     = "test-30068"
  region      = "us-central1"
  zone        = "us-central1-c"
}