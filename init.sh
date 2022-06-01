#!/usr/bin/env bash
set -euo pipefail

VERSION=main

init() {
    TEMP=$(mktemp -d) && cd "$TEMP"
    wget https://github.com/prasetiyohadi/dotfiles/archive/refs/heads/$VERSION.zip
    unzip -q $VERSION.zip
    cp -pr dotfiles-$VERSION/.[^.]* ~/
    cd && rm -fr "$TEMP"
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
