FROM docker.io/node:16.20.2-alpine as builder
WORKDIR /usr/src/app
COPY . .
RUN npm install && npm run build


FROM docker.io/nginx:1.27.0-alpine
COPY --from=builder /usr/src/app/dist/ /usr/share/nginx/html
COPY ./nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80