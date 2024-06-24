resource "yandex_compute_instance" "instance" {
  name                      = var.name
  platform_id               = "standard-v2"
  zone                      = var.zone
  allow_stopping_for_update = true

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 50
  }

  boot_disk {
    initialize_params {
      image_id = "fd828qsqv1jtq2qec4m5"
    }
  }

  network_interface {
    subnet_id = var.subnet_id
    nat_ip_address = var.ip_address
    nat = true
  }

  scheduling_policy {
    preemptible = false
  }

  metadata = {
    user-data = templatefile("${path.module}/metadata/users.tpl", {
      ssh_public_key = var.ssh_public_key
      instance_user_name = var.instance_user_name
    })
  }
}