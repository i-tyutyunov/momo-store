variable "folder_id" {
  description = "ID каталога в облаке"
  type = string
}

variable "zone" {
  description = "Зона доступности"
  type = string
  default = "ru-central1-a"
}

variable "instance_user_name" {
  description = "Имя пользователя, для подлючения к виртуальной машине"
  type = string
  default = "ansible"
}

variable "ssh_public_key" {
  description = "Публичный ключ SSH для подключения к виртуальной машине"
  type = string
}