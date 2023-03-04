#!/usr/bin/env bash

if ! [ -x "$(command -v rlwy)" ]; then
    echo >&2 "Error: Railway CLI is not installed."
    echo >&2 "Use:"
    echo >&2 "    cargo install railwayapp --locked"
    echo >&2 "to install it."
    exit 1
fi

# Prompt:
#     - Empty Project
#     - Project Name
#     - Description
rlwy init

rlwy add --plugin postgresql

# Still no way to opt out from deploy
rlwy up -d

# Cannot set variables
# railway variables set \
#     PORT=8000 \
#     APP_DATABASE__DATABASE_NAME='${{ PGDATABASE }}' \
#     APP_DATABASE__HOST='${{ PGHOST }}' \
#     APP_DATABASE__PASSWORD='${{ PGPASSWORD }}' \
#     APP_DATABASE__PORT='${{ PGPORT }}' \
#     APP_DATABASE__USERNAME='${{ PGUSER }}'

rlwy run sqlx migrate run

# railway up -d
