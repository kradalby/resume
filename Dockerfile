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


RUN apt-get update && apt-get install -y \
        xvfb \
        x11-xkb-utils \
        xfonts-100dpi \
        xfonts-75dpi \
        xfonts-scalable \
        xfonts-cyrillic \
        x11-apps \
        clang \
        libdbus-1-dev \
        libgtk2.0-dev \
        libnotify-dev \
        libgnome-keyring-dev \
        libgconf2-dev \
        libasound2-dev \
        libcap-dev \
        libcups2-dev \
        libxtst-dev \
        libxss1 \
        libnss3-dev \
        gcc-multilib \
        g++-multilib

ENV DISPLAY ":9.0"
# needs full path
# https://github.com/fraserxu/electron-pdf/issues/173#issuecomment-417807284
RUN Xvfb :9 -screen 0 1280x2000x32 > /dev/null 2>&1 & 
RUN xvfb-run -n 9 npx electron-pdf /app/dist/index.html /app/dist/resume.pdf
RUN ls dist

FROM nginx:alpine
COPY --from=elm /app/dist /usr/share/nginx/html
