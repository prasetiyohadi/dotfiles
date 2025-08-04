#!/usr/bin/env bash
set -euo pipefail

# Install packages using pkg helper
install_packages() {
  local packages
  packages="bat eza fzf rsync gh gum jq lazygit nap fuse3 neovim pet ripgrep stow thefuck tmux tmuxp yq zellij"

  for pkg in ${packages}; do
    bash ./pkg/pkg.sh "${pkg}"
  done
}

# Packages with custom installation scripts

# arkade: https://arkade.dev/docs/installation/#installation
install_arkade() {
  curl -sLS https://get.arkade.dev | sudo sh
  arkade completion zsh | sudo tee /usr/local/share/zsh/site-functions/_arkade
  export PATH=$PATH:$HOME/.arkade/bin
  local packages
  packages=""
  # packages="${packages} atuin dagger fzf gh jq lazygit yq"
  # packages="${packages} helm kubectl kubectx kubens kustomize stern"
  # packages="${packages} k9s kind kubie vault"
  for pkg in ${packages}; do
    arkage get "${pkg}"
  done
}

# atuin: https://docs.atuin.sh/guide/installation/#recommended-installation-approach
install_atuin() {
  curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh
}

install_dagger() {
  # dagger: https://docs.dagger.io/install/
  curl -fsSL https://dl.dagger.io/dagger/install.sh | BIN_DIR=$HOME/.local/bin sh
  dagger completion zsh | sudo tee /usr/local/share/zsh/site-functions/_dagger
}

# devbox: https://www.jetify.com/devbox/docs/installing_devbox/
install_devbox() {
  curl -fsSL https://get.jetify.com/devbox | bash
}

# direnv: https://direnv.net/docs/installation.html
install_direnv() {
  mkdir -p "${HOME}/.local/bin"
  export bin_path=${HOME}/.local/bin
  curl -sfL https://direnv.net/install.sh | bash
}

# kcl: https://www.kcl-lang.io/docs/user_docs/getting-started/install#from-nix-packages
install_kcl() {
  wget -q https://kcl-lang.io/script/install-cli.sh -O - | /bin/bash
}

# pet: https://github.com/knqyf263/pet?tab=readme-ov-file#binary
install_pet() {
  mkdir -p ~/.config/pet
  touch ~/.config/pet/snippet.toml
}

# starship: https://starship.rs/guide/#%F0%9F%9A%80-installation
install_starship() {
  curl -sS https://starship.rs/install.sh | sh
}

# zinit: https://github.com/zdharma-continuum/zinit?tab=readme-ov-file#install
install_zinit() {
  bash -c "$(curl --fail --show-error --silent --location \
    https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
}

# zoxide: https://github.com/ajeetdsouza/zoxide?tab=readme-ov-file#installation
install_zoxide() {
  curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
}

# Install Nix

install_nix() {
  # nix: https://nix.dev/install-nix
  if eval "nix-env --version 2>&1 >/dev/null"; then
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

  # teller: https://github.com/tellerops/teller?tab=readme-ov-file
  nix-env -f '<nixpkgs>' -iA teller
}

install_packages
install_arkade
install_atuin
install_dagger
install_devbox
install_direnv
install_kcl
install_pet
install_starship
install_zinit
install_zoxide
install_nix
