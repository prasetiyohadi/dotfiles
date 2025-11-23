#!/usr/bin/env bash
set -euo pipefail

# Populate secrets
if [[ -f secrets.env ]]; then
  source secrets.env
fi

# Generate config file from template
envsubst <.config/pet/config.toml.tpl >.config/pet/config.toml
envsubst <.gitconfig.tpl >.gitconfig

chmod og-rwx .config/pet/config.toml

CURRENT_DATE=$(date +%Y%m%d-%H%M%S)
mv -v ~/.config/atuin/config.toml{,".bak-$CURRENT_DATE"}
mv -v ~/.config/mise/config.toml{,".bak-$CURRENT_DATE"}
mv -v ~/.config/pet/config.toml{,".bak-$CURRENT_DATE"}
mv -v ~/.gitconfig{,".bak-$CURRENT_DATE"}
mv -v ~/.tmux.conf{,".bak-$CURRENT_DATE"}
mv -v ~/.zshenv{,".bak-$CURRENT_DATE"}
mv -v ~/.zshrc{,".bak-$CURRENT_DATE"}

# Create symlinks for the config files
stow .

echo '### Execute `source ~/.zshrc`.' | gum format
