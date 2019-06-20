#!/bin/bash
# Checks if there's a composer.json, and if so, installs/runs composer.

set -euo pipefail

cd /opt/app/

# Using sandstorm branch (branch from 1.4.0)
# git checkout sandstorm

bash bin/setup

cat <<EOF > /opt/app/.sequelizerc
var path = require('path');

module.exports = {
    'config':          path.resolve('config.json'),
    'migrations-path': path.resolve('lib', 'migrations'),
    'models-path':     path.resolve('lib', 'models'),
    'url':             'mysql://app:20976d20aa2059a6e087773da9f41f07@127.0.0.1:3306/app'
}
EOF

cat <<EOF > /opt/app/config.json
{
    "test": {
        "db": {
            "dialect": "sqlite",
            "storage": ":memory:"
        }
    },
    "development": {
        "loglevel": "debug",
        "hsts": {
            "enable": false
        },
        "db": {
            "dialect": "sqlite",
            "storage": "./db.codimd.sqlite"
        }
    },
    "production": {
        "hsts": {
            "enable": false,
            "maxAgeSeconds": 31536000,
            "includeSubdomains": true,
            "preload": true
        },
        "csp": {
            "enable": false,
            "directives": {
            },
            "upgradeInsecureRequests": "auto",
            "addDefaults": true,
            "addDisqus": true,
            "addGoogleAnalytics": true
        },
        "db": {
            "username": "app",
            "password": "20976d20aa2059a6e087773da9f41f07",
            "database": "app",
            "host": "127.0.0.1",
            "port": "3306",
            "dialect": "mysql"
        },
        "uploadsPath": "/var/codimd/uploads"
    }
}
EOF

npm run build
