resource "yandex_vpc_network" "default" {
  name = "default"
  folder_id = var.folder_id
}

resource "yandex_vpc_subnet" "subnet" {
  name           = "${yandex_vpc_network.default.name}-${var.zone}"
  v4_cidr_blocks = ["192.168.0.0/28"]
  zone           = var.zone
  network_id     = yandex_vpc_network.default.id
}