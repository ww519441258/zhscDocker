#!/bin/bash
/etc/init.d/nginx start
/etc/init.d/php-fpm start
/etc/init.d/mariadb start
/usr/local/bin/redis-server /etc/redis.conf
/bin/bash
