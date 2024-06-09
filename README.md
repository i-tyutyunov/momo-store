# Momo Store aka Пельменная №2

<img width="900" alt="image" src="https://user-images.githubusercontent.com/9394918/167876466-2c530828-d658-4efe-9064-825626cc6db5.png">

## Frontend

```bash
npm install
NODE_ENV=production VUE_APP_API_URL=http://localhost:8081 npm run serve
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