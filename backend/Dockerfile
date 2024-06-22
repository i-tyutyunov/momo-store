FROM docker.io/golang:alpine3.20
WORKDIR /usr/src/app

ENV APP_USER=gouser APP_GROUP=gouser


RUN addgroup --system $APP_USER && adduser -S -s /bin/false -G $APP_GROUP $APP_USER -D && chown $APP_USER ./

USER $APP_USER

COPY . .

EXPOSE 8081
ENTRYPOINT ["go", "run", "./cmd/api"]