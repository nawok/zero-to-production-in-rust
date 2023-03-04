#!/usr/bin/env bash

if ! [ -x "$(command -v railway)" ]; then
    echo >&2 "Error: Railway CLI is not installed."
    echo >&2 "Use:"
    echo >&2 "    brew install railway"
    echo >&2 "to install it."
    exit 1
fi

# Prompt:
#     - Select Starting Point: Empty Project
#     - Enter project name: zero2prod
#     - Environment: production (set automatically)
#     - Import your variables into Railway?: N
railway init

# Prompt:
#     - Select Plugin: postgresql
railway add

# No way to opt out from deploy
# Just need to create a container for my variables below
# And run migrations before the first deploy
railway up -d
railway down --yes

railway run sqlx migrate run

railway variables set \
    PORT=8000 \
    APP_DATABASE__DATABASE_NAME='${{ PGDATABASE }}' \
    APP_DATABASE__HOST='${{ PGHOST }}' \
    APP_DATABASE__PASSWORD='${{ PGPASSWORD }}' \
    APP_DATABASE__PORT='${{ PGPORT }}' \
    APP_DATABASE__USERNAME='${{ PGUSER }}'

railway up -d

# Need to set up the domain manually
