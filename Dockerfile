FROM ghcr.io/linuxserver/baseimage-alpine-nginx:3.14

LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="alex-phillips"

RUN \
  echo "**** install runtime packages ****" && \
  apk add --update --no-cache \
    curl \
    composer \
    php7 \
    php7-ctype \
    php7-curl \
    php7-exif \
    php7-gd \
    php7-json \
    php7-mbstring \
    php7-pdo \
    php7-pdo_mysql \
    php7-zip \
    php7-session \
    php7-xml \
    php7-fileinfo && \
  echo "**** install chevereto-free-multi-language ****" && \
  mkdir -p /app/chevereto

COPY . /app/chevereto

RUN \
  cd /app/chevereto && \
  composer install && \
  echo "**** cleanup ****" && \
  rm -rf \
    /root/.cache \
    /tmp/*

COPY root/ /

EXPOSE 80 443

VOLUME /config
