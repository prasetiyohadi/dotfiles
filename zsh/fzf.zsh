# Auto-completion
# ---------------
[[ $- == *i* ]] && source "$(find $HOME/.asdf/installs/fzf -iname completion.zsh)" 2> /dev/null

# Key bindings
# ------------
source "$(find $HOME/.asdf/installs/fzf -iname key-bindings.zsh)"
