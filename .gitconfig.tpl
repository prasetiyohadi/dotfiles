# You can look up popular git options here: https://jvns.ca/blog/2024/02/16/popular-git-config-options/

[alias]
    # List files which have changed since REVIEW_BASE
    # (REVIEW_BASE defaults to 'master' in my ~/.zshrc)
    files = !git diff --name-only $(git merge-base HEAD \"$REVIEW_BASE\")

    # Same as above, but with a diff stat instead of just names
    # (better for interactive use)
    stat = !git diff --stat $(git merge-base HEAD \"$REVIEW_BASE\")

    # `git dft` is less to type than `git difftool`.
    dft = difftool

[color]
    ui = auto

[core]
    packedGitLimit = 512m
    packedGitWindowSize = 512m
    pager = less -FX

[pack]
    deltaCacheSize = 2047m
    packSizeLimit = 2047m
    windowMemory = 2047m
    window = 1

# Add the following to your .gitconfig to use difftastic as your difftool.
[diff]
    tool = difftastic

[difftool]
    prompt = false

[difftool "difftastic"]
    cmd = difft "$LOCAL" "$REMOTE"

[init]
    defaultBranch = main
    #templateDir = ~/.git-template

# Use a pager for large output, just like other git commands.
[pager]
    difftool = true

[pull]
    rebase = false

[user]
    email = $GIT_EMAIL
    name = $GIT_NAME

[include]
    path = ~/.custom.gitconfig
