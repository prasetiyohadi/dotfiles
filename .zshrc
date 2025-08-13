# zmodload zsh/zprof  # start profiling
# Load compinit
autoload -Uz compinit
if [ "$(date +'%j')" != "$(stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)" ]; then
    compinit
else
    compinit -C
fi

# Environment variables
export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.atuin/bin:$PATH"  # atuin
export PATH="$HOME/.local/go/bin:$PATH" # go
export PATH="$PATH:$HOME/.iximiuz/labctl/bin" # iximiuz: labctl
export PATH="$PATH:$HOME/.arkade/bin" # arkade
export PATH="$HOME/.opencode/bin:$PATH"  # opencode

# Completions
eval "$(devbox global shellenv)"
eval "$(atuin init zsh)"
eval "$(direnv hook zsh)"
eval "$(starship init zsh)"
eval "$(thefuck --alias)"
eval "$(zoxide init --cmd cd zsh)"
source <(devbox completion zsh)
source <(docker completion zsh)
source <(fzf --zsh) # set up fzf key bindings and fuzzy completion
source <(labctl completion zsh) # iximiuz: labctl completion
command -v kubectl 2>&1 >/dev/null && source <(kubectl completion zsh) || true

# Aliases
alias '?'='which'
alias cat='bat --paging never --theme DarkNeon --style plain'
alias cwd='pwd | awk -F/ "{print \$NF}"'
alias dex='docker exec'
alias dexit='docker exec -it'
alias dag='dagger'
alias drund='docker run -d --rm'
alias drunit="docker run -d --entrypoint '' --init --rm"
alias fk='thefuck'
alias fzfp='fzf --preview "bat --style numbers --color always {}"'
alias gbD='git branch -D'
alias gcb='git checkout -b'
alias gcB='git checkout -B'
alias gdf='git dft'
alias gfa='git fetch --all --prune --jobs=10'
alias ggpush='git push origin "$(git_current_branch)"'
alias gts='git tag -s'
alias l='eza --long --all --git --group-directories-first'
alias ls='eza --long --all --no-permissions --no-filesize --no-user --no-time --git'
alias lst='eza --long --all --no-permissions --no-filesize --no-user --git --sort modified'
alias kckc='echo $KUBECONFIG'
alias kn='kubens'
alias krun='kubectl run'
alias kubi='kubie'
alias kx='kubectx'
alias napl='nap $(nap list | gum filter)'
# alias pbcopy='xsel --clipboard --input'
# alias pbpaste='xsel --clipboard --output'
PROXY_SRC=
NO_PROXY_SRC='"localhost,127.0.0.1"'
alias proxy_up='export ftp_proxy=$PROXY_SRC http_proxy=$PROXY_SRC https_proxy=$PROXY_SRC no_proxy=$NO_PROXY_SRC'
alias proxy_down='unset ftp_proxy http_proxy https_proxy no_proxy'
alias sp='steampipe'
alias tv='tidy-viewer'
alias vi='nvim'
alias vim='nvim'
alias zj='zellij'

# Ansible
export ANSIBLE_NOCOWS=1

# Atuin
export ATUIN_NOBIND="true"

# Devbox
DEVBOX_NO_PROMPT=true

# Difft
export DFT_GRAPH_LIMIT=30000000

# Editor
# Preferred editor for local and remote sessions
export EDITOR=nvim
export VISUAL=nvim

# Git
LANG=en_US.UTF-8

# Glibc-locales: https://github.com/NixOS/nix/issues/599
export LOCALE_ARCHIVE="$(nix-env --installed --no-name --out-path --query glibc-locales)/lib/locale/locale-archive"

# Gitconfig
export GIT_SSH_COMMAND=${GIT_SSH_COMMAND:-ssh}
export REVIEW_BASE=origin/main

# GPG
if [[ ! "$(echo $OSTYPE | tr -d '[:digit:][:punct:]')" == "darwin" ]]; then
    export GPG_TTY=$(tty)
    [[ ! -n "${SSH_AUTH_SOCK+1}" ]] && export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
fi

# History
## History file configuration
[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh_history"
[ "$HISTSIZE" -lt 50000 ] && HISTSIZE=50000
[ "$SAVEHIST" -lt 50000 ] && SAVEHIST=50000

## History command configuration
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_find_no_dups      # do not display a line previously found
setopt hist_ignore_all_dups   # delete old recorded entry if new entry is a duplicate
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_save_no_dups      # don't write duplicate entries in the history file
setopt hist_verify            # show command with history expansion to user before running it
setopt inc_append_history     # add commands to HISTFILE in order of execution
setopt share_history          # share command history data

# Minio client
if [ $(command -v mc) ]; then
    autoload -U +X bashcompinit && bashcompinit
    complete -o nospace -C $(command -v mc) mc
fi

# Nix
if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then . ~/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

# Pet
zle -N pet-select
stty -ixon

# Rustup
. "$HOME/.cargo/env"

# Terraform
if [ $(command -v terraform) ]; then
    autoload -U +X bashcompinit && bashcompinit
    complete -o nospace -C $(command -v terraform) terraform
fi

# Tmux
if [[ -n "${TMUX+1}" && -n "${SSH_AUTH_SOCK+1}" ]]; then
    tmux set-environment SSH_AUTH_SOCK $SSH_AUTH_SOCK
fi

# Tmuxp
export DISABLE_AUTO_TITLE='true'

# Zinit
### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

# ZSH
WORDCHARS=''
export -U PATH # deduplicate PATH

# ZSH plugins
zinit light zsh-users/zsh-completions
zinit light Aloxaf/fzf-tab
# zinit light davidde/git
# zinit light yzdann/kctl
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-history-substring-search
zinit light zsh-users/zsh-syntax-highlighting # always last

# ZSH style
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
# NOTE: don't use escape sequences here, fzf-tab will ignore them
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no
# preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
# switch group using `<` and `>`
zstyle ':fzf-tab:*' switch-group '<' '>'

# NOTE: patch 'fzf-tab' plugin because it is not working properly with default fzf preview
# https://github.com/Aloxaf/fzf-tab/issues/461
zstyle ':fzf-tab:complete:*' fzf-preview '[[ $(file --mime $realpath) =~ binary ]] && echo "$word is a binary file" || (bat --style=numbers --color=always $realpath || cat $realpath) 2>/dev/null | head -300'

# # use fzf-tab tmux "popup" feature, but there is issue with width
# # https://github.com/Aloxaf/fzf-tab/issues/235
# zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup

# # NOTE: temporary fix fzf-tab tmux "popup" width issue, not so pretty
#
# zstyle ':fzf-tab:*' popup-min-size 80 20

# ZSH keybindings
bindkey -e
bindkey '^ ' autosuggest-accept
bindkey '^r' _atuin_search_widget
bindkey '^s' pet-select
bindkey '^[[A' history-substring-search-up
if [[ -n "${terminfo[kcuu1]}" ]]; then
  bindkey "${terminfo[kcuu1]}" history-substring-search-up
fi
bindkey '^[[B' history-substring-search-down
if [[ -n "${terminfo[kcud1]}" ]]; then
  bindkey "${terminfo[kcud1]}" history-substring-search-down
fi
bindkey '^[[1~' beginning-of-line
bindkey '^[[4~' end-of-line

### Start ZSH functions ###

# Name: body()
# Description: print the header (the first line of input)
# and then run the specified command on the body (the rest of the input)
# use it in a pipeline, e.g. ps | body grep somepattern
body() {
  IFS= read -r header
  printf '%s\n' "$header"
  "$@"
}

# Name: br()
# Description: custom broot function, need broot to be installed
br() {
  local cmd cmd_file code
  cmd_file=$(mktemp)
  if broot --outcmd "$cmd_file" "$@"
  then
    cmd=$(<"$cmd_file")
    command rm -f "$cmd_file"
    eval "$cmd"
  else
    code=$?
    command rm -f "$cmd_file"
    return "$code"
  fi
}

# Name: die()
# Description: exit with an error message
die() {
  printf '%s\n' "$1" >&2
  exit 1
}

# Name: gch()
# Description: fuzzy find through your git branches
gch() {
  git checkout "$(git branch --all | fzf | tr -d '[:space:]\*')"
}

# Name: lg()
# Description: change directory into that repo on exiting lazygit
lg()
{
  export LAZYGIT_NEW_DIR_FILE=~/.lazygit/newdir
  lazygit "$@"
  if [ -f $LAZYGIT_NEW_DIR_FILE ]; then
    cd "$(cat $LAZYGIT_NEW_DIR_FILE)"
    rm -f $LAZYGIT_NEW_DIR_FILE > /dev/null
  fi
}

# Name: prev
# Description: register previous command snippet with pet
function prev()
{
  PREV=$(fc -lrn | head -n 1)
  sh -c "pet new `printf %q "$PREV"`"
}

# Name: pet-select
# Description: select snippet from pet
function pet-select() {
  BUFFER=$(pet search --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle redisplay
}

# Name: git_main_branch
# Description: return the main git branch
function git_main_branch() {
  def=`git remote show origin | sed -n '/HEAD branch/s/.*: //p'`
  echo $def
}

# Name: git_current_branch
# Description: Outputs the name of the current branch
# Usage example: git pull origin $(git_current_branch)
# Using '--quiet' with 'symbolic-ref' will not cause a fatal error (128) if
# it's not a symbolic ref, but in a Git repo.
function git_current_branch() {
  local ref
  ref=$(git symbolic-ref --quiet HEAD 2> /dev/null)
  local ret=$?
  if [[ $ret != 0 ]]; then
    [[ $ret == 128 ]] && return  # no git repo.
    ref=$(git rev-parse --short HEAD 2> /dev/null) || return
  fi
  echo ${ref#refs/heads/}
}

### End custom functions ###
# zprof # end profiling
