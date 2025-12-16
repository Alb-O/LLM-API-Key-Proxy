#!/usr/bin/env bash
cd "$(dirname "$0")"
exec nix develop -c bash -c 'source venv/bin/activate && python src/proxy_app/main.py "$@"' _ "$@"
