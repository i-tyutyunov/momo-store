terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"

  backend "http" {
    address        = "https://gitlab.praktikum-services.ru/api/v4/projects/6488/terraform/state/momo-store-state"
    lock_address   = "https://gitlab.praktikum-services.ru/api/v4/projects/6488/terraform/state/momo-store-state/lock"
    unlock_address = "https://gitlab.praktikum-services.ru/api/v4/projects/6488/terraform/state/momo-store-state/lock"
    lock_method    = "POST"
    unlock_method  = "DELETE"
    retry_wait_min = 5
  }
}