FROM node:lts-jessie-slim as build-stage

WORKDIR app/

COPY package*.json /app/

RUN npm install

COPY ./ /app/

RUN npm run build

FROM nginx:stable

COPY --from=build-stage /app/dist /usr/share/nginx/html

COPY --from=build-stage /app/nginx.conf /etc/nginx/conf.d/default.conf
