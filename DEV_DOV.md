## DEV_DOC.md

# Developer Documentation - Inception

This document details the internal architecture and technical choices made during the development of the Inception project.

## System Architecture
The project follows a micro-services architecture where each service runs in a dedicated container based on **Debian Bullseye**.

### Service Overview
1.  **Nginx**: The entry point (TLS v1.2/1.3). It handles HTTPS requests and proxies PHP traffic to WordPress.
2.  **WordPress**: Runs PHP-FPM 7.4. It handles the application logic and communicates with the database.
3.  **MariaDB**: The database engine storing WordPress tables and data.

### Network Logic
All containers are connected via a private bridge network named `inception_network`. 
* **MariaDB** is isolated and only accessible by WordPress on port 3306.
* **WordPress** communicates with Nginx via port 9000.
* Only **Nginx** exposes port 443 to the Host machine.


## Directory Structure
* `srcs/docker-compose.yml`: Main orchestration file.
* `srcs/requirements/nginx/`: Dockerfile and `.conf` for the web server.
* `srcs/requirements/mariadb/`: Dockerfile and initialization scripts for the DB.
* `srcs/requirements/wordpress/`: Dockerfile and `setup.sh` for the CMS.
* `data/`: Host-side persistent storage (Bind Mounts).

## Service Details & Logic

### WordPress Setup Script (`setup.sh`)
The WordPress container uses a custom script to automate installation:
1.  **Waiting Period**: It waits for MariaDB to be ready.
2.  **WP-CLI**: It downloads and installs WordPress core using the Command Line Interface.
3.  **Config & Users**: It creates the `wp-config.php` and sets up the admin and a secondary author user using environment variables.
4.  **Permissions**: It recursively applies `chown www-data:www-data` to ensure PHP-FPM has write access to the volume.

### Nginx Proxying
Nginx is configured as a FastCGI proxy. It uses `fastcgi_param SCRIPT_FILENAME` to tell PHP-FPM exactly which file to execute within the shared volume. 
The `try_files $uri $uri/ /index.php?$args;` directive ensures that WordPress permalinks and the REST API function correctly.


## Debugging Tools
* **Shell Access:** `docker exec -it <container_name> bash`
* **Network Inspection:** `docker network inspect inception_network`
* **Configuration Testing:** * Nginx: `nginx -t` inside the container.
  * MariaDB: `mysql -u root -p` inside the container.

### Mariadb

Inspect Mariadb with command: \
`docker exec -it mariadb mariadb -u root -p` \
`show DATABASES;` See list of databases \
`use nameOfDataBase;` Select a database from the list \
`show TABLES;` Show lines from a table \
`select * FROM tableLine;` Show content of table \
`quit` Quit

### Volumes

inspect volumes with
`docker volume inspect NameOfVolume`