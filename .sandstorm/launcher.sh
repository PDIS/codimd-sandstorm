#!/bin/bash

# Create a bunch of folders under the clean /var that php, nginx, and mysql expect to exist
mkdir -p /var/lib/mysql
mkdir -p /var/lib/mysql-files
mkdir -p /var/log
mkdir -p /var/log/mysql
# Wipe /var/run, since pidfiles and socket files from previous launches should go away
# TODO someday: I'd prefer a tmpfs for these.
rm -rf /var/run
rm -rf /var/tmp
mkdir -p /var/tmp
mkdir -p /var/run/mysqld

# Ensure mysql tables created
# HOME=/etc/mysql /usr/bin/mysql_install_db
HOME=/etc/mysql /usr/sbin/mysqld --initialize

# Spawn mysqld, php
HOME=/etc/mysql /usr/sbin/mysqld --skip-grant-tables &
# Wait until mysql and php have bound their sockets, indicating readiness
while [ ! -e /var/run/mysqld/mysqld.sock ] ; do
    echo "waiting for mysql to be available at /var/run/mysqld/mysqld.sock"
    sleep .2
done

# Create database & user
echo "CREATE DATABASE /*!32312 IF NOT EXISTS*/ app /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */; CREATE USER IF NOT EXISTS 'app'@'127.0.0.1' IDENTIFIED BY '20976d20aa2059a6e087773da9f41f07'; GRANT ALL ON `database`.* TO 'app'@'127.0.0.1'" | mysql -uroot

cd /opt/app

# Run migration
sequelize db:migrate

# Run app
export NODE_ENV=production
export CMD_ALLOW_ORIGIN=*.local.sandstorm.io
export CMD_DOMAIN=$ROOT_URL
export CMD_USECDN=false
export CMD_LOG_LEVEL=debug
export CMD_PROTOCOL_USESSL=false
export CMD_SINGLE_NOTE=true
node app.js
