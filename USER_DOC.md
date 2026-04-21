# User Documentation - Inception

This document provides instructions on how to install, run, and access the Inception web infrastructure.

## Prerequisites
Before starting, ensure your system has:
* **Docker** and **Docker Compose** installed.
* **Make** utility.
* A Unix-based operating system (macOS or Linux).

## Getting Started

### 1. Domain Configuration
The project is configured to run on a specific local domain. You must map `dsatge.42.fr` to your local IP.
Run the following command in your terminal:
```bash
sudo echo "127.0.0.1 dsatge.42.fr" >> /etc/hosts
```
### 2. Environment Setup
create a .env file in hte srcs/ directory. it needs the following variables :
DOMAIN_NAME= ******** \
*Mariadb* \
SQL_DATABASE= ******** \
SQL_USER= ******** \
SQL_PASSWORD= ******** \
SQL_ROOT_PASSWORD= ******** \
*Wordpress Admin* \
WP_ADMIN_USER= ******** \
WP_ADMIN_PASSWORD= ******** \
WP_ADMIN_EMAIL= ******** \
*WordPress User* \
WP_USER= ******** \
WP_USER_PASSWORD= ******** \
WP_USER_EMAIL= ******** 

### 3. Launching the infrastructure

Navigate to the root of the project and run: \
`make` Set up directories, build images, and start containers. \
`make clean` Stop and remove containers and networks. \
`make fclean` Full cleanup (containers, images, volumes, and data folders). \
`make re` Force a complete rebuild of the infrastructure.

Once the containers are "Healthy" and "Started", you can access the service via your browser: \
Website (Frontend): https://dsatge.42.fr \
WordPress Admin (Backend): https://dsatge.42.fr/wp-admin \
WordPress User (Backend): https://dsatge.42.fr/wp-user \

> [!NOTE]
> Since the SSL certificate is self-signed, your browser will show a security warning. You can safely bypass this by clicking "Advanced" and "Proceed to site."