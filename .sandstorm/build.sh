#!/bin/bash
# Checks if there's a composer.json, and if so, installs/runs composer.

set -euo pipefail

cd /opt/app/

bash bin/setup
npm run build

npm prune --production
npm install sqlite3