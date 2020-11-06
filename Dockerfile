FROM php:7.2-apache


RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
    && docker-php-ext-configure gd \
        --with-png-dir=/usr/ \
        --with-jpeg-dir=/usr/ \
        --with-freetype-dir=/usr/ \
    && docker-php-ext-install gd

# install php required extentions
RUN docker-php-ext-install \
    pdo \
    pdo_mysql \
    gettext \
    mbstring

# Install git
# RUN apt-get install -y git
# clone the mibew messenger repository
# RUN git clone https://github.com/Mibew/mibew.git && cp -R mibew/src/mibew/* /var/www/html/
# TODO: install node and gulp to build from source

# Enviroment variables
ENV MIBEW_VERSION 3.2.6
ENV MIBEW_SHA1 be85f53c7a83d3c9c33ccaa92be210d332e534c7

# change workdir to home
WORKDIR /~

# Download archive
RUN curl -o mibew.tar.gz -fSL "https://downloads.sourceforge.net/project/mibew/core/${MIBEW_VERSION}/mibew-${MIBEW_VERSION}.tar.gz"; \
    # check sha1 sum
	echo "$MIBEW_SHA1 *mibew.tar.gz" | sha1sum -c -; \
    # Extract files to apache root folder
	tar -xzf mibew.tar.gz --strip 1 -C /var/www/html/; \
    # remove downloaded archive
	rm mibew.tar.gz; \
    # change permissions
	chown -R www-data:www-data /var/www/html;

# create a volume for the config file
VOLUME /var/www/html/configs/config.yml
