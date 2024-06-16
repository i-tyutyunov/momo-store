# Momo Store aka Пельменная №2

<img width="900" alt="image" src="https://user-images.githubusercontent.com/9394918/167876466-2c530828-d658-4efe-9064-825626cc6db5.png">

## Frontend

```bash
npm install
NODE_ENV=production VUE_APP_API_URL=http://localhost:8081 npm run serve
```

```bash
docker build -t momo-store-frontend:0.0.1 ./frontend
docker run --name momo-store-frontend -p 8080:8080 momo-store-frontend:0.0.1

```


## Backend

```bash
go run ./cmd/api
go test -v ./... 
```

### Docker

```bash
docker build -t momo-store-backend:0.0.1 ./backend
docker run --name momo-store-backend -p 8081:8081 momo-store-backend:0.0.1

```

## Infrastructure

### Terraform

_На момент работы с terraform у вас должен быть файл с авторизационным ключом_ 
```bash
yc config profile create memo-store-terraform
yc config set service-account-key key.json
yc config set cloud-id <идентификатор_облака>
yc config set folder-id <идентификатор_каталога>

export YC_TOKEN=$(yc iam create-token)
export YC_CLOUD_ID=$(yc config get cloud-id)
export YC_FOLDER_ID=$(yc config get folder-id)

# Переменные для доступа к хранилищу состояния
export GITLAB_USER_NAME=<логин в GitLab>
export GITLAB_ACCESS_TOKEN=<access токен в Gitlab>

export TF_VAR_folder_id=$YC_FOLDER_ID
export TF_VAR_instance_user_name=<имя пользователя для доступа к ВМ>
export TF_VAR_ssh_public_key=<публичный ключ для доступа к ВМ>

cd ~/infrastructure/terraform
terraform init -backend-config="username=$GITLAB_USER_NAME" -backend-config="password=$GITLAB_ACCESS_TOKEN"
terraform apply
```



### Ansible

Для запуска docker-compose на целевой машине, в ansible должен быть установлен модуль `community.docker` >= 3.
```shell
ansible-galaxy collection list
ansible-galaxy collection install community.docker

```

```bash
cd ~/infrastructure/ansible
ansible-playbook playbook.yml --tags role-dependencies
ansible-playbook playbook.yml --tags role-common
ansible-playbook playbook.yml --tags role-backend
ansible-playbook playbook.yml --tags role-frontend

```
или

```bash
cd ~/infrastructure/ansible
ansible-playbook playbook.yml

```
### Docker compose

**Для прода:** docker-compose up 
**Для локальной разработки:** docker-compose --env-file .env_local up 

### Docker Registry
Образы хранятся в GitLab. Доступ к чтению и записи образов происходит по токену проекта

Дальнейший план:
    Задача минимум:
        1. Используем docker-registry GitLab: добиваемся того, чтобы виртуалка могла качать образы
        2. Пишем CI/CD;
        3. Реализуем ssl-сертификат самым простым способом
        4. На этом в целом можно сдавать работу, но можно сделать лучше.
    
    Задача максимум:
        1. Делаем возможным масштабирование приложения через docker-compose(смотрим на пример из курса)
        2. Ставим вперери ещё балансировщик и для него выпускаем сертификат. А за балансировщиком ставим виртуалку;
        3. Предусматриваем возможность увеличения количества виртуалок.