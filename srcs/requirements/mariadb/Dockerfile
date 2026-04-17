FROM debian:bullseye

# installation and update
RUN apt-get update && apt install -y mariadb-server && rm -rf /var/lib/apt/lists/*

# folders creation of PID and socketd
RUN mkdir -p /var/run/mysqld \
	&& chown -R mysql:mysql /var/run/mysqld \
	&& chmod 777 /var/run/mysqld

# modify config file to the set up one
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# install database with setup config
COPY tools/db_setup.sh /usr/local/bin/db_setup.sh
RUN chmod +x /usr/local/bin/db_setup.sh

# share Mariadb port
EXPOSE 3306

# launching script
ENTRYPOINT ["/usr/local/bin/db_setup.sh"]