# This is a multi-stage Dockerfile and requires >= Docker 17.05
# https://docs.docker.com/engine/userguide/eng-image/multistage-build/
#
#
FROM node:lts-buster as elm
WORKDIR /app

COPY Makefile package.json ./
RUN make install

COPY . .
RUN make build


RUN apt-get update && apt-get install -y \
        xvfb \
        x11-xkb-utils \
        # xfonts-100dpi \
        # xfonts-75dpi \
        # xfonts-scalable \
        # xfonts-cyrillic \
        x11-apps \
        clang \
        libdbus-1-dev \
        libgtk2.0-dev \
        libnotify-dev \
        libgconf2-dev \
        libasound2-dev \
        libcap-dev \
        libcups2-dev \
        libxtst-dev \
        libxss1 \
        libnss3-dev \
        gcc-multilib \
        g++-multilib \
        && yarn add electron-pdf@1.3.2

# needs full path
# https://github.com/fraserxu/electron-pdf/issues/173#issuecomment-417807284
ENV DISPLAY ":9.0"
RUN xvfb-run npx electron-pdf /app/dist/index.html /app/dist/resume.pdf

FROM nginx:alpine
COPY --from=elm /app/dist /usr/share/nginx/html
