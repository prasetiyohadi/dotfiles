#!/usr/bin/env bash
set -euo pipefail

# Create local executable directory
mkdir -p ~/.local/bin

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

# atuin: https://docs.atuin.sh/guide/installation/#installing-the-binary
nix-env -f '<nixpkgs>' -iA atuin

# bat: https://github.com/sharkdp/bat?tab=readme-ov-file#installation
nix-env -f '<nixpkgs>' -iA bat

# devbox: https://www.jetify.com/devbox/docs/installing_devbox/
curl -fsSL https://get.jetify.com/devbox | bash

# direnv: https://direnv.net/docs/installation.html
nix-env -f '<nixpkgs>' -iA direnv

# eza: https://github.com/eza-community/eza/blob/main/INSTALL.md
nix-env -f '<nixpkgs>' -iA eza

# fzf: https://github.com/junegunn/fzf?tab=readme-ov-file#installation
nix-env -f '<nixpkgs>' -iA fzf

# gh: https://github.com/cli/cli/blob/trunk/docs/install_linux.md
nix-env -f '<nixpkgs>' -iA gh

# glibc-locales
nix-env -f '<nixpkgs>' -iA glibcLocales

# gum: https://github.com/charmbracelet/gum?tab=readme-ov-file#installation
nix-env -f '<nixpkgs>' -iA gum

# jq: https://github.com/jqlang/jq?tab=readme-ov-file#installation
nix-env -f '<nixpkgs>' -iA jq

# kcl: https://www.kcl-lang.io/docs/user_docs/getting-started/install#from-nix-packages
nix-env -f '<nixos-24.05>' -iA kcl-cli

# nap: https://github.com/maaslalani/nap?tab=readme-ov-file#installation
wget -qO - https://github.com/maaslalani/nap/releases/download/v0.1.1/nap_0.1.1_linux_amd64.tar.gz | tar -xzf - -C ~/.local/bin

# nvim: https://github.com/neovim/neovim/blob/master/INSTALL.md#linux
nix-env -f '<nixpkgs>' -iA neovim

# pet: https://github.com/knqyf263/pet?tab=readme-ov-file#binary
wget -qO - https://github.com/knqyf263/pet/releases/download/v0.9.0/pet_0.9.0_linux_amd64.tar.gz | tar -xzf - -C ~/.local/bin
mkdir -p ~/.config/pet
touch ~/.config/pet/snippet.toml

# rg: https://github.com/BurntSushi/ripgrep?tab=readme-ov-file#installation
nix-env -f '<nixpkgs>' -iA ripgrep

# starship: https://starship.rs/guide/#%F0%9F%9A%80-installation
curl -sS https://starship.rs/install.sh | sh

# stow: https://www.gnu.org/software/stow/
nix-env -f '<nixpkgs>' -iA stow

# tmux: https://github.com/tmux/tmux/wiki/Installing#installing-tmux
nix-env -f '<nixpkgs>' -iA tmux

# tmuxp: https://github.com/tmux-python/tmuxp?tab=readme-ov-file#installation
nix-env -f '<nixpkgs>' -iA tmuxp

# thefuck: https://github.com/nvbn/thefuck?tab=readme-ov-file#installation
nix-env -f '<nixpkgs>' -iA thefuck

# yq: https://github.com/mikefarah/yq?tab=readme-ov-file#install
sudo bash -c "wget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -O /usr/bin/yq &&\
    chmod +x /usr/bin/yq"

# zinit: https://github.com/zdharma-continuum/zinit?tab=readme-ov-file#install
bash -c "$(curl --fail --show-error --silent --location \
	https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"

# zoxide: https://github.com/ajeetdsouza/zoxide?tab=readme-ov-file#installation
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
