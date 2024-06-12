variable "name" {
  description = "Название виртуальной машины"
  type = string
}

variable "ip_address" {
  description = "Публичный IP-адрес"
  type = string
}

variable "folder_id" {
  description = "ID каталога в облаке"
  type = string
}

variable "zone" {
  description = "Зона доступности"
  type = string
}

variable "subnet_id" {
  description = "ID подсети"
  type = string
}

variable "ssh_public_key" {
  description = "Публичный ключ SSH для подключения к виртуальной машине"
  type = string
}

variable "instance_user_name" {
  description = "Имя пользователя, для подлючения к виртуальной машине"
  type = string
}