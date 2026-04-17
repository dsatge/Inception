FROM debian:bullseye

# installation and update
RUN apt-get update && apt install -y nginx openssl
# creation of folder for ssl certificate
RUN mkdir -p /etc/nginx/ssl
# auto-signed certificate
## req = certificate creation
## -x509 = type of certificate
## -nodes = no password required
## -out / keyout = location to save files
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=login.42.fr/UID=login"

# create file for PID file
RUN mkdir -p /var/run/nginx
# gives user rights to write
RUN chown -R www-data:www-data /var/run/nginx

# replace default conf with our personnalised one
COPY conf/nginx.conf /etc/nginx/conf.d/default.conf

# Set up to make Nginx works foreground or stop
CMD ["nginx", "-g", "daemon off;"]