FROM php:8.1-apache

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libonig-dev \
    && docker-php-ext-configure gd \
        --with-jpeg=/usr/ \
        --with-freetype=/usr/ \
    && docker-php-ext-install gd

# install php required extentions
RUN docker-php-ext-install \
    pdo \
    pdo_mysql \
    gettext \
    mbstring
  
# Enviroment variables
ARG MIBEW_VERSION=3.5.7
ARG MIBEW_SHA1=b511aed34e22ed97752e0185997cee79daacd4f7
ARG MIBEW_DE_SHA1=5f9c6053560b72a3f06d626a6bd83af9a2cce37e

# change workdir to home
WORKDIR /root

# Download archive
RUN curl -o mibew.tar.gz -fSL "https://downloads.sourceforge.net/project/mibew/core/${MIBEW_VERSION}/mibew-${MIBEW_VERSION}.tar.gz" && \
  # check if file exists, just to be safe
    test -f "mibew.tar.gz" && \
  # check sha1 sum
	  echo "$MIBEW_SHA1 *mibew.tar.gz" | sha1sum -c -&& \
  # Extract files to apache root folder
	#tar -xzf mibew.tar.gz --strip 1 -C /var/www/html/ && \
	  tar -xzf mibew.tar.gz -C /var/www/html/ && \
  # remove downloaded archive
	  rm mibew.tar.gz && \
  # change permissions
	  chown -R www-data:www-data /var/www/html && \
  # download locales de
    curl -o mibew-i18n-de.tar.gz -fSL "https://sourceforge.net/projects/mibew/files/i18n/de/${MIBEW_VERSION}/mibew-i18n-de-${MIBEW_VERSION}-20221022.tar.gz" && \
    test -f "mibew-i18n-de.tar.gz" && \
  # check sha1 sum
    echo "$MIBEW_DE_SHA1 mibew-i18n-de.tar.gz" | sha1sum -c - && \
  # Extract files to apache root folder
    tar -xzf mibew-i18n-de.tar.gz -C /var/www/html/mibew/locales/ && \
  # remove archive
    rm mibew-i18n-de.tar.gz
  # delete configurable folders, exposed as volume(s) (no need to actually delete those, will be overlayed)
    #rm -rf "/var/www/html/mibew/styles" "/var/www/html/mibew/sounds" "/var/www/html/mibew/plugins" "/var/www/html/mibew/locales" ;

# create a volume for the config file(s)
VOLUME ["/var/www/html/mibew/styles", "/var/www/html/mibew/plugins", "/var/www/html/mibew/locales", "/var/www/html/mibew/sounds", "/var/www/html/mibew/configs/config.yml"]
