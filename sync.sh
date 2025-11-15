#!/usr/bin/env bash
set -euo pipefail

rm -f ~/.zshrc

# Populate secrets
if [[ -f secrets.env ]]; then
  source secrets.env
fi

# Generate config file from template
envsubst <.config/pet/config.toml.tpl >.config/pet/config.toml
envsubst '$GIT_EMAIL,$GIT_NAME' <.gitconfig.tpl >.gitconfig

chmod og-rwx .config/pet/config.toml

# Create symlinks for the config files
stow .

echo '### Execute `source ~/.zshrc`.' | gum format
