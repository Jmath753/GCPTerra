resource "google_service_account" "GCPvm1" {
  account_id   = "gcp-103"
  display_name = "Jeremy Mathew"
}

resource "google_compute_instance" "myvm1" {
  name         = "myvm1"
  machine_type = "n1-standard-1"
  hostname = "myvm1.com"
  zone         = "us-central1-a"
  allow_stopping_for_update = true  
  tags = ["foo", "bar"]

  labels = {
    name = "myvm1",
    owner = "jeremy",
    user = "jeremy",
    dept = "it",
    os = "windows" 
  }

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
    #email  = "terraform-admin@test-30068.iam.gserviceaccount.com"
    scopes = ["cloud-platform"]
  }
}