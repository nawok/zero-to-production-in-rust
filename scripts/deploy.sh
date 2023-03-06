#!/usr/bin/env bash

if ! [ -x "$(command -v railway)" ]; then
    echo >&2 "Error: Railway CLI is not installed."
    echo >&2 "Use:"
    echo >&2 "    cargo install railwayapp --locked"
    echo >&2 "to install it."
    exit 1
fi

railway init --name zero2prod
railway add --plugin postgresql
railway run sqlx migrate run
railway up -d

# Down command is missing in CLIv3, use the old one
railway2 down --yes

# Cannot set variables in CLIv3, use the old one
railway2 variables set \
    PORT=8000 \
    APP_DATABASE__DATABASE_NAME='${{ PGDATABASE }}' \
    APP_DATABASE__HOST='${{ PGHOST }}' \
    APP_DATABASE__PASSWORD='${{ PGPASSWORD }}' \
    APP_DATABASE__PORT='${{ PGPORT }}' \
    APP_DATABASE__USERNAME='${{ PGUSER }}' \
    APP_APPLICATION__BASE_URL=https://zero2prod.up.railway.app

# Random domain
railway domain

railway up -d
