# Momo Store aka Пельменная №2

Проект можно разделить на следующие части:

1. Frontend
2. Backend
3. Terraform
4. Ansible
5. CI/CD

## Frontend и Backend

Frontend: `mm-store.243075.ru`.
Backend: `mm-store.243075.ru/api/`.

Собираются из исходников в docker-образы. Образы хранятся в GitLab Container Registry.
При шаге `deploy`, в CI/CD, образы запускаются на ВМ с помощью Ansible и docker-compose.

Тестовое окружение не предусмотрено.

**Как запустить локально:**

_Для запуска у вас должен быть доступ к GitLab Container Registry_

```shell
docker login -u $CI_REGISTRY_USER -p $CI_REGISTRY_PASSWORD gitlab.praktikum-services.ru:5050
docker-compose --env-file .env.example up
```

## Terraform

Terraform используется для создания инфраструктуры в Yandex Cloud.

А именно:

1. Облачная сеть и подсеть;
2. Статичный IP-адрес;
3. Виртуальная машина.

Создание этих ресурсов оформлено в виде модулей.

В качестве хранилища состояния используется [GitLab Terraform states](https://gitlab.praktikum-services.ru/std-025-75/momo-store/-/terraform)

В output Terraform возвращает `ip_address` - IP-адрес ВМ.
В CI/CD этот адрес пробрасывается в Ansible, где прописывается в `/etc/hosts`.

**Необходимые параметры для Terraform**

```shell
export YC_SERVICE_ACCOUNT_KEY_FILE=<путь к ключу авторизации от сервисного аккаунта в YC>
export YC_CLOUD_ID=<id облака>
export YC_FOLDER_ID=<id каталога>

export TF_VAR_folder_id=$YC_FOLDER_ID
export TF_VAR_instance_user_name=<пользователь для Ansible>
export TF_VAR_ssh_public_key=<открытый ключ для пользователя Ansible>

# Для доступа к хранилищу состояния
export TF_HTTP_USERNAME=<имя токена в GitLab>
export TF_HTTP_PASSWORD=<токен проекта в GitLab>

terraform init -reconfigure
terraform apply 
terraform output ip_address
```

## Ansible

Ansible разбит на следующие роли:

1. `dependencies` - установка ПО на ВМ;
2. `common` - подготовка ВМ к деплою фронтенда и бэкенда. _Копирование `.env`, `docker-compose.yml`, авторизация в 
   GitLab Container Registry;_
3. `backend` - деплой бэкенда;
4. `frontend` - деплой фронтенда.

Доступы от Container Registry зашифрованы с помощь ansible-vault. 
Путь к файлу с паролем от vault находится в штатной, для Ansible, переменной `ANSIBLE_VAULT_PASSWORD_FILE` GitLab CI/CD.

Приватный ключ для Ansible находится в переменной `SSH_PRIVATE_KEY`.
Открытый ключ - в `TF_VAR_ssh_public_key`. Он помещается на ВМ при её создании через Terraform.

**О запуске ролей**

Каждая роль указана в `playbook.yml` и помечена тегом. Таким образом можно разделять применение Ansible на этапы:

```shell
ansible-playbook playbook.yml --tags role-dependencies
ansible-playbook playbook.yml --tags role-common
ansible-playbook playbook.yml --tags role-backend
ansible-playbook playbook.yml --tags role-frontend
```

## CI/CD

В CI/CD можно использовать только ветку `main`, т.к. окружения для тестирования не предусмотрено.

CI/CD разделён на этапы:

- test
- build
- terraform
- ansible
- deploy

**test**

Запускаются тесты бэкенда. Конфиг Ansible пропускается через `ansible-lint`. Для Terraform запускается `terraform 
validate`.

**build**

Происходит создание docker-образов фронтенда и бэкенда. Созданные образы 
помещаются в [GitLab Container Registry](https://gitlab.praktikum-services.ru/std-025-75/momo-store/container_registry)

**terraform**

Запускается `terraform plan` и вручную нужно запустить `terraform apply`.
После `terraform apply` из `output ip_address` получаем IP ВМ и пробрасываем его в Ansible через артефакт. 

**ansible**

Запускает роль `dependencies`: Установка ПО на ВМ, IP-адрес которой был получен из `terraform output ip_address`.

А также роль `common`, которая готовит ВМ к деплою бэкенда и фронтанда: копирование `docker-compose.yml`, копирование 
переменных окружения (`.env`) для docker-compose, авторизация в Container Registry.

Перед копированием файла с переменными окружения (`.env`), в него добавляются переменные `BACKEND_IMAGE_TAG` и 
`FRONTEND_IMAGE_TAG`, в которые записываются версии образов. Версии образов - это коротких хеш коммита. 

**deploy**

Непосредственный деплой фронтенда и бэкенда на ВМ. Для этого также используется Ansible, а именно роли `backend` и 
`frontend`. Роль `frontend` также занимается настройкой nginx и установкой SSL-сертификата.
