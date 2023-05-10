#!/bin/sh
set -e

echo "[Start entrypoint.sh]"

# Configuration file preparation
#echo "Configuration file preparation"

#config.php in /usr/html
#if [ -f /usr/html/config.php ]; then
#	if [ ! -L /usr/html/config.php ]; then
	  #config.php is file in /usr/html
#	  echo "config.php is file in /usr/html"
#	  echo "config.php move to  /ttrss/config.php"
#	  cp /usr/html/config.php /ttrss/config.php
#	  rm /usr/html/config.php	  
#	fi  
#fi

#config.php in volume
#if [ -f /ttrss/config.php ]; then
#	echo "[i] Creating link to config.php"
#    ln -s /ttrss/config.php /usr/html/config.php
#fi

echo "[i] Fixing permissions..."
chown -R nginx:nginx /usr/html
chown -R nginx:www-data /usr/html

# start php-fpm
echo "start php-fpm"

php-fpm7

# start cron
echo "start cron"

#/usr/sbin/crond -b
/usr/sbin/crond -b -l 0 -L /dev/null 2>&1

# start nginx
echo "start nginx"
mkdir -p /tmp/nginx
mkdir -p /tmp/nginx/body
mkdir -p /tmp/nginx/fastcgi_temp

chown nginx /tmp/nginx
chown nginx /run/nginx
chown nginx /var/run

#
exec "$@"