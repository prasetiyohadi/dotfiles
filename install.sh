#!/usr/bin/env bash
set -euo pipefail

# Install packages using pkg helper
PACKAGES="bat eza fzf gh gum jq lazygit nap neovim pet ripgrep stow thefuck tmux tmuxp"

for pkg in ${PACKAGES}; do
	bash ./pkg/pkg.sh ${pkg}
done

# Packages with custom installation scripts

# atuin: https://docs.atuin.sh/guide/installation/#recommended-installation-approach
curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh

# devbox: https://www.jetify.com/devbox/docs/installing_devbox/
curl -fsSL https://get.jetify.com/devbox | bash

# direnv: https://direnv.net/docs/installation.html
mkdir -p ${HOME}/.local/bin
export bin_path=${HOME}/.local/bin
curl -sfL https://direnv.net/install.sh | bash

# kcl: https://www.kcl-lang.io/docs/user_docs/getting-started/install#from-nix-packages
wget -q https://kcl-lang.io/script/install-cli.sh -O - | /bin/bash

# pet: https://github.com/knqyf263/pet?tab=readme-ov-file#binary
mkdir -p ~/.config/pet
touch ~/.config/pet/snippet.toml

# starship: https://starship.rs/guide/#%F0%9F%9A%80-installation
curl -sS https://starship.rs/install.sh | sh

# zinit: https://github.com/zdharma-continuum/zinit?tab=readme-ov-file#install
bash -c "$(curl --fail --show-error --silent --location \
	https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"

# zoxide: https://github.com/ajeetdsouza/zoxide?tab=readme-ov-file#installation
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

# Install Nix

# nix: https://nix.dev/install-nix
if $(nix-env --version 2>&1 >/dev/null); then
	echo "nix is already installed"
else
	curl -L https://nixos.org/nix/install | sh -s -- --daemon
fi

nix-channel --add https://nixos.org/channels/nixos-24.05
nix-channel --add https://nixos.org/channels/nixpkgs-unstable
nix-channel --list
nix-channel --update

# glibc-locales: https://github.com/NixOS/nix/issues/599
nix-env -f '<nixpkgs>' -iA glibcLocales
