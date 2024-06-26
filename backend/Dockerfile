FROM docker.io/golang:alpine3.20 as builder
WORKDIR /usr/src/app
COPY . .
RUN go build -o momo-store-backend ./cmd/api

FROM docker.io/alpine:3.20.1
ENV APP_USER=gouser APP_GROUP=gouser
WORKDIR /usr/src/app

RUN addgroup --system $APP_USER && adduser -S -s /bin/false -G $APP_GROUP $APP_USER -D && chown $APP_USER ./
USER $APP_USER

COPY --from=builder /usr/src/app/momo-store-backend ./
EXPOSE 8081
ENTRYPOINT ["./momo-store-backend"]