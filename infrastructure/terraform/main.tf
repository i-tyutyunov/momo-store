module "network" {
  source = "./modules/network"
  folder_id = var.folder_id
  zone = var.zone
}

module "ip_address" {
  source = "./modules/ip_address"
  folder_id = var.folder_id
  zone = var.zone

  name = "memo-store-ip"
}

output "ip_address" {
  value = module.ip_address.ip_address
}

module "instance" {
  source = "./modules/instance"
  folder_id = var.folder_id
  zone = var.zone

  ip_address = module.ip_address.ip_address
  name = "momo-store-instance"
  subnet_id = module.network.subnet_id
  instance_user_name = var.instance_user_name
  ssh_public_key = var.ssh_public_key
}