#!/usr/bin/env bash
set -euo pipefail

init() {
    cd
    git init
    git remote add origin https://github.com/prasetiyohadi/dotfiles.git
    git pull --ff-only origin main
    git branch -m main
    git branch --set-upstream-to=origin/main main
}

setup() {
    cd
    bash .dotfiles/setup.sh
}

main() {
    init
    setup
}

main
