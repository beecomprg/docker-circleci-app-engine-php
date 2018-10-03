FROM php:7.2-fpm-alpine
ENV CLOUD_SDK_VERSION 219.0.1

ENV PATH /google-cloud-sdk/bin:$PATH
RUN set -x && apk update && apk --no-cache add \
    libxml2 libxml2-dev wget curl git \
    curl \
    python \
    bash \
    libc6-compat \
    openssh-client \
    git \
    patch \
	wget && \
	rm /var/cache/apk/* && \
	cd / && curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    tar xzf google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    rm google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    ln -s /lib /lib64 && \
    gcloud config set core/disable_usage_reporting true && \
    gcloud config set component_manager/disable_update_check true && \
    gcloud config set metrics/environment github_docker_image && \
    gcloud --version && \
 docker-php-ext-install \
  bcmath \
  opcache \
  pdo_mysql \
  soap \
  zip && \
  curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

ENV PHP_MEMORY_LIMIT 2G
ENV PHP_PORT 9000
ENV PHP_PM dynamic
ENV PHP_PM_MAX_CHILDREN 20
ENV PHP_PM_START_SERVERS 10
ENV PHP_PM_MIN_SPARE_SERVERS 4
ENV PHP_PM_MAX_SPARE_SERVERS 10