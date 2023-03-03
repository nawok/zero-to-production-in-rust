# Zero to Production in Rust

[![CI](https://github.com/nawok/zero-to-production-in-rust/actions/workflows/general.yml/badge.svg)](https://github.com/nawok/zero-to-production-in-rust/actions/workflows/general.yml)
[![Security audit](https://github.com/nawok/zero-to-production-in-rust/actions/workflows/audit.yml/badge.svg)](https://github.com/nawok/zero-to-production-in-rust/actions/workflows/audit.yml)
[![Coverage](https://codecov.io/gh/nawok/zero-to-production-in-rust/branch/main/graph/badge.svg?token=QPWIT4AS4P)](https://codecov.io/gh/nawok/zero-to-production-in-rust)

## Faster inner development loop

1. Install an alternative linker for the current OS (see `Cargo.toml`)
2. `cargo install cargo-watch`
3. `cargo watch -x check -x test -x run`

## De-occupy the port

```shell
lsof -t -i tcp:8000 | xargs kill -9
```

## Expand macros

1. `cargo install cargo-expand`
2. `rustup toolchain install nightly --allow-downgrade`
3. `cargo +nightly expand`

## Remove unused dependencies

1. `cargo install cargo-udeps`
2. `cargo +nightly udeps`

## Docker

```sh
# Update SQLx schema for offline builds
cargo sqlx prepare -- --lib

# Build and run image
docker build --tag zero2prod --file Dockerfile .
docker run -p 8000:8000 --network=host zero2prod
```
