// Configure the Google Cloud provider
provider "google" {
 credentials = file("test-30068-f9df025cb8e6.json")
  project = "test-30068"
 region      = "us-west1"
}

resource "google_service_account" "default" {
  account_id   = "terraform-admin"
  display_name = "Service Account_Jeremy"
}


resource "google_compute_instance" "default" {
  name         = "Test"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }


  // Local SSD disk
  scratch_disk {
    interface = "SCSI"
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }

  metadata = {
    foo = "bar"
  }

  metadata_startup_script = "echo hi > /test.txt"

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.default.email
    scopes = ["cloud-platform"]
  }
}