#!/bin/bash
/etc/init.d/nginx start
/etc/init.d/php-fpm start
/etc/init.d/mariadb start
/etc/init.d/redis start
#/etc/init.d/mongo start
/bin/bash
