
resource "random_id" "project_id" {
  byte_length = 4
}

module "project" {
  for_each = toset(["dev", "prod"])

  source          = "../modules/project"
  billing_account = var.billing_account
  name            = "${each.value}-${random_id.project_id.hex}"
  prefix          = "sg"
  parent          = "organizations/1098571864372"
  services        = [
    "compute.googleapis.com",
  ]
  iam = {}
}

resource "time_sleep" "wait_30_seconds_for_prod_dev" {
  depends_on      = [
      module.project["prod"],
      module.project["dev"]
      ]

  create_duration = "30s"
}


resource "google_project_iam_member" "cloudbuild_sa_prod_dev" {
    for_each = toset(["prod", "dev"])

    project = module.project["${each.value}"].project_id
    depends_on = [
      time_sleep.wait_30_seconds_for_prod_dev
    ]
    role    = "roles/owner"
    member  = "serviceAccount:${google_project.project.number}@cloudbuild.gserviceaccount.com"
}



module "vpc-internal" {
  for_each   = toset(["dev", "prod"])

  source     = "../modules/net-vpc"
  project_id = "sg-${each.value}-${random_id.project_id.hex}"
  
  depends_on = [
      time_sleep.wait_30_seconds_for_prod_dev
    ]
  name       = "vpc-internal-0"
  subnets    = [
    {
      ip_cidr_range = "10.1.1.0/24"
      name          = "int-0-subnet-a"
      region        = "europe-central2"
      secondary_ip_range = {}

      },
    {
      ip_cidr_range = "10.1.16.0/24"
      name          = "int-0-subnet-b"
      region        = "europe-central2"
      secondary_ip_range = {}
    }
  ]
}