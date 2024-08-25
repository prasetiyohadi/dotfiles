#!/usr/bin/env bash
set -euo pipefail

rm -f ~/.zshrc

# Populate secrets from `.envrc` file
if [[ -f .envrc ]]; then
	eval "$(teller sh)"
fi

# Generate config file from template
envsubst <.config/pet/config.toml.tpl >.config/pet/config.toml
envsubst '$GIT_EMAIL,$GIT_NAME' <.gitconfig.tpl >.gitconfig

chmod og-rwx .config/pet/config.toml

# Create symlinks for the config files
stow .

echo '### Execute `source ~/.zshrc`.' | gum format
