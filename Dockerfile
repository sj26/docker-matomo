FROM ubuntu:bionic

RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install --assume-yes --no-install-recommends \
      ca-certificates \
      curl \
      ssl-cert \
      apache2 \
      libapache2-mod-php \
      php-apcu \
      php-dom \
      php-gd \
      php-geoip \
      php-ldap \
      php-mbstring \
      php-mysql \
      php-opcache \
      php-redis \
      php-xml \
      php-zip \
      && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 80 443

ENV APACHE_RUN_USER=www-data \
  APACHE_RUN_GROUP=www-data \
  APACHE_LOCK_DIR=/var/lock/apache2 \
  APACHE_LOG_DIR=/var/log/apache2 \
  APACHE_RUN_DIR=/var/run/apache2 \
  APACHE_PID_FILE=/var/run/apache2/apache2.pid

ADD apache2/ /etc/apache2/

RUN sed -i -e "s/^PidFile/# PidFile/" /etc/apache2/apache2.conf && \
    sed -i -e "s/^ErrorLog .*/ErrorLog \/dev\/stderr/" /etc/apache2/apache2.conf && \
    a2disconf other-vhosts-access-log.conf && \
    a2disconf serve-cgi-bin.conf && \
    a2enmod ssl && \
    a2dissite "*" && \
    a2ensite matomo

WORKDIR /var/www/matomo

ADD --chown=root:www-data matomo/ ./
ADD --chown=root:www-data config/ ./config/
RUN chmod g+w config piwik.js && chmod -R g+w tmp

CMD ["apache2", "-D", "FOREGROUND", "-d", "/etc/apache2"]
