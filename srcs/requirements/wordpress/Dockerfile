FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    wget \
    curl \
    php7.4 \
    php7.4-fpm \
    php7.4-mysql \
    php7.4-curl \
    php7.4-gd \
    php7.4-intl \
    php7.4-mbstring \
    php7.4-xml \
    php7.4-zip \
    mariadb-client \
    && rm -rf /var/lib/apt/lists/*

# download WP-CLI -> online tool for wordpress commands
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x wp-cli.phar \
	&& mv wp-cli.phar /usr/local/bin/wp

# folder for php-fpm and rights
RUN mkdir -p /run/php

#modify listen port to 9000 so nginx can communicate with it
RUN sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 9000/g' /etc/php/7.4/fpm/pool.d/www.conf

# copy script and gives rights
COPY tools/setup.sh /usr/local/bin/setup.sh
RUN chmod +x /usr/local/bin/setup.sh

# set up into web folder
WORKDIR /var/www/html

ENTRYPOINT ["/usr/local/bin/setup.sh"]