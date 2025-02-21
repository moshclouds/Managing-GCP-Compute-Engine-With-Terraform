module "compute" {
  source = "./modules/compute"
  machine_type = var.machine_type
  zone = var.zone
}