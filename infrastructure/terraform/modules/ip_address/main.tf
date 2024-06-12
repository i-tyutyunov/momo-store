resource "yandex_vpc_address" "ip_address" {
  name = var.name
  deletion_protection = false
  external_ipv4_address {
    zone_id = var.zone
  }
}