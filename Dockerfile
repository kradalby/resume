# This is a multi-stage Dockerfile and requires >= Docker 17.05
# https://docs.docker.com/engine/userguide/eng-image/multistage-build/
#
#
FROM node:10 as elm
WORKDIR /app

COPY package.json .
RUN yarn install --silent

COPY elm.json .

ENV NODE_ENV "production"
COPY . .
RUN yarn run prod


FROM nginx:alpine
COPY --from=elm /app/dist /usr/share/nginx/html
