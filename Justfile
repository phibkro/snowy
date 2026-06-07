#!/usr/bin/env just --justfile
# Snowy dev recipes. Run inside the project root.

default: dev

# Build + run snowy in the dev shell. Opens the libadwaita window.
@dev:
    nix develop -c cargo run

# Build only, don't run. Useful for "does it still compile" iteration.
@build:
    nix develop -c cargo build

# Watch mode — rebuilds on save. Doesn't auto-restart the window; use
# manually when iterating on non-runtime code.
@watch:
    nix develop -c cargo watch -x build

# Format + lint pass. Run before committing.
@check:
    nix develop -c cargo fmt --check
    nix develop -c cargo clippy -- -D warnings
    nix fmt -- flake.nix

# Format everything in place.
@fmt:
    nix develop -c cargo fmt
    nix fmt -- flake.nix
