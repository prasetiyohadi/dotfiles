#!/usr/bin/env bash
set -euo pipefail

# nix: https://nix.dev/install-nix
if [ $(nix-env --version 2>&1 >/dev/null) ]; then
	echo "nix is already installed"
else
	curl -L https://nixos.org/nix/install | sh -s -- --daemon
fi

nix-channel --add https://nixos.org/channels/nixos-24.05
nix-channel --add https://nixos.org/channels/nixpkgs-unstable
nix-channel --list
nix-channel --update

# bat: https://github.com/sharkdp/bat?tab=readme-ov-file#installation
nix-env -f '<nixpkgs>' -iA bat

# devbox: https://www.jetify.com/devbox/docs/installing_devbox/
curl -fsSL https://get.jetify.com/devbox | bash

# eza: https://github.com/eza-community/eza/blob/main/INSTALL.md
nix-env -f '<nixpkgs>' -iA eza

# fzf: https://github.com/junegunn/fzf?tab=readme-ov-file#installation
nix-env -f '<nixpkgs>' -iA fzf

# gh: https://github.com/cli/cli/blob/trunk/docs/install_linux.md
nix-env -f '<nixpkgs>' -iA gh

# gum: https://github.com/charmbracelet/gum?tab=readme-ov-file#installation
nix-env -f '<nixpkgs>' -iA gum

# jq: https://github.com/jqlang/jq?tab=readme-ov-file#installation
nix-env -f '<nixpkgs>' -iA jq

# kcl: https://www.kcl-lang.io/docs/user_docs/getting-started/install#from-nix-packages
nix-env -f '<nixos-24.05>' -iA kcl-cli

# nvim: https://github.com/neovim/neovim/blob/master/INSTALL.md#linux
nix-env -f '<nixpkgs>' -iA neovim

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
