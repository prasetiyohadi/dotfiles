# Need to be updated everytime we update fzf version in asdf
# Auto-completion
# ---------------
[[ $- == *i* ]] && source "$(find $HOME/.asdf/installs/fzf -iname key-bindings.zsh)" 2> /dev/null

# Key bindings
# ------------
source "$(find $HOME/.asdf/installs/fzf -iname key-bindings.zsh)"
