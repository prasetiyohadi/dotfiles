[General]
snippetfile = "~/.config/pet/snippet.toml"
editor = "nvim"
column = 40
selectcmd = "fzf --ansi --layout=reverse --border --height=90% --pointer='*' --cycle --prompt='Snippets: '"
backend = "gist"
sortby = ""

[Gist]
file_name = "pet-snippet.toml"
access_token = "$GITHUB_ACCESS_TOKEN"
gist_id = "$GITHUB_GIST_ID"
public = false
auto_sync = true

[GitLab]
file_name = "pet-snippet.toml"
access_token = ""
url = ""
id = ""
visibility = "private"
auto_sync = false
skip_ssl = false
