#!/bin/bash
# Checks if there's a composer.json, and if so, installs/runs composer.

set -euo pipefail

cd /opt/app/

# Using sandstorm branch (branch from 1.4.0)
# git checkout sandstorm

bash bin/setup
npm run build
