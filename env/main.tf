module "firewall-int" {
  source = "../modules/net-vpc-firewall-yaml"
  
  project_id         = var.project_id
  network            = var.project_vpc_internal
  config_directories = [
    "../firewall_rules",
  ]
}

