resource "random_id" "id" {
  byte_length = 4
  prefix      = "${var.project_name}-"
}

resource "google_project" "project" {
  name                = var.project_name
  project_id          = random_id.id.hex
  billing_account     = var.billing_account
  auto_create_network = false
}


resource "google_project_service" "service" {
  for_each = toset([
    "cloudbuild.googleapis.com",
  ])

  service            = each.key
  project            = google_project.project.project_id
  disable_on_destroy = false
}

resource "time_sleep" "wait_30_seconds" {
  depends_on      = [
      google_project.project
      ]

  create_duration = "30s"
}

resource "google_project_iam_member" "cloudbuild_sa" {
    project = google_project.project.project_id
    depends_on = [
      time_sleep.wait_30_seconds
    ]
    role    = "roles/editor"
    member  = "serviceAccount:${google_project.project.number}@cloudbuild.gserviceaccount.com"
}



resource "google_storage_bucket" "tfstate" {
  name          ="${google_project.project.project_id}-tfstate"
  project       = "${google_project.project.project_id}"
  location      = "EU"
  force_destroy = true
  versioning     {
      enabled = true
  }
  
}


output "tfstate_bucket_name" {
    value = google_storage_bucket.tfstate.name
}
