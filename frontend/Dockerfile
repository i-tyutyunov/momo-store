FROM node:16.20.2-alpine

WORKDIR /usr/src/app

COPY . .

ENV APP_USER=nodeuser APP_GROUP=nodeuser
RUN addgroup --system $APP_USER && adduser -S -s /bin/false -G $APP_GROUP $APP_USER -D && chown $APP_USER ./

RUN npm install

USER $APP_USER

EXPOSE 8080
ENTRYPOINT ["npm", "run", "serve"]