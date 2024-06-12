output "ip_address" {
  value = yandex_vpc_address.ip_address.external_ipv4_address[0].address
}