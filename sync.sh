#!/usr/bin/env bash
set -euo pipefail

rm -f ~/.zshrc

# Populate secrets
if [[ -f secrets.env ]]; then
  source secrets.env
fi

# Generate config file from template
envsubst <.config/pet/config.toml.tpl >.config/pet/config.toml
envsubst <.gitconfig.tpl >.gitconfig

chmod og-rwx .config/pet/config.toml

mv -v ~/.config/atuin/config.toml{,".bak-$(date +%Y%m%d-%H%M%S)"}
mv -v ~/.config/mise/config.toml{,".bak-$(date +%Y%m%d-%H%M%S)"}
mv -v ~/.config/pet/config.toml{,".bak-$(date +%Y%m%d-%H%M%S)"}
mv -v ~/.gitconfig{,".bak-$(date +%Y%m%d-%H%M%S)"}
mv -v ~/.tmux.conf{,".bak-$(date +%Y%m%d-%H%M%S)"}
mv -v ~/.zshenv{,".bak-$(date +%Y%m%d-%H%M%S)"}

# Create symlinks for the config files
stow .

echo '### Execute `source ~/.zshrc`.' | gum format
