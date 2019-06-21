#!/bin/bash

# When you change this file, you must take manual action. Read this doc:
# - https://docs.sandstorm.io/en/latest/vagrant-spk/customizing/#setupsh

set -euo pipefail

export DEBIAN_FRONTEND=noninteractive


# Install MySQL && NodeJS && yarn
echo -e "deb http://repo.mysql.com/apt/debian/ stretch mysql-5.7\ndeb-src http://repo.mysql.com/apt/debian/ stretch mysql-5.7" > /etc/apt/sources.list.d/mysql.list
wget -O /tmp/RPM-GPG-KEY-mysql https://repo.mysql.com/RPM-GPG-KEY-mysql
apt-key add /tmp/RPM-GPG-KEY-mysql

curl -sL https://deb.nodesource.com/setup_10.x | bash

curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

apt-get update
apt-get install -y mysql-server nodejs yarn git
service mysql stop
systemctl disable mysql
# patch mysql conf to not change uid, and to use /var/tmp over /tmp
# for secure-file-priv see https://github.com/sandstorm-io/vagrant-spk/issues/195
sed --in-place='' \
        --expression='s/^user\t\t= mysql/#user\t\t= mysql/' \
        --expression='s,^tmpdir\t\t= /tmp,tmpdir\t\t= /var/tmp,' \
        --expression='/\[mysqld]/ a\ secure-file-priv = ""\' \
        /etc/mysql/my.cnf
# patch mysql conf to use smaller transaction logs to save disk space
cat <<EOF > /etc/mysql/conf.d/sandstorm.cnf
[mysqld]
# Set the transaction log file to the minimum allowed size to save disk space.
innodb_log_file_size = 1048576
# Set the main data file to grow by 1MB at a time, rather than 8MB at a time.
innodb_autoextend_increment = 1
EOF

## NODE package
npm install -g node-gyp sequelize-cli

# Install library which needed by node package
apt-get install -y g++ libssl-dev

# Mount directories avoiding sync with outside Virtualbox
mkdir -p /var/codimd_node_modules
mkdir -p /var/codimd_public_build
mkdir -p /var/codimd_public_views_build
mkdir -p /opt/app/node_modules
mkdir -p /opt/app/public/build
mkdir -p /opt/app/public/views/build
mount --bind /var/codimd_node_modules /opt/app/node_modules
mount --bind /var/codimd_public_build /opt/app/public/build
mount --bind /var/codimd_public_views_build /opt/app/public/views/build
echo 'mount --bind /var/codimd_node_modules /opt/app/node_modules' >> ~/.bashrc
echo 'mount --bind /var/codimd_public_build /opt/app/public/build' >> ~/.bashrc
echo 'mount --bind /var/codimd_public_views_build /opt/app/public/views/build'  >> ~/.bashrc
chown vagrant /opt/app/node_modules
chown vagrant /opt/app/public/build
chown vagrant /opt/app/public/views/build
