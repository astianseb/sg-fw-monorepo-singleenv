output "storage_bucket_tfstate" {
  value = google_storage_bucket.tfstate.name
}

output "dev-project-id" {
    value = module.project["dev"].project_id
  
}

output "prod-project-id" {
    value = module.project["prod"].project_id

}

output "dev-project-vpc-internal" {
  value = module.vpc-internal["dev"].name
}

output "prod-project-vpc-internal" {
  value = module.vpc-internal["prod"].name
}