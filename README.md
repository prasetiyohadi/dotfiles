# Dotfiles

This repository stores the configuration of my $HOME directory.
To use the configuration in this repository, use the following command.

```shell
curl -fsSL https://raw.githubusercontent.com/prasetiyohadi/dotfiles/main/.dotfiles/init.sh | bash
```

DO NOT FORGET to update the `.gitconfig` to use your email and your name.

```
[user]
	email = <your email>
	name = <your name>
```

## Setup Dotfiles

This directory stores files and scripts required to install required applications and setup configuration files. The setup process can be executed by using the following commands.

```shell
cd
bash .dotfiles/setup.sh
```
## Applications

### Neovim

[Neovim](https://neovim.io/) is a Vim-fork focused on extensibility and usability.

### Oh My Zsh

[Oh My Zsh](https://ohmyz.sh/) is a delightful, open source, community-driven framework for managing your Zsh configuration. It comes bundled with thousands of helpful functions, helpers, plugins, themes, and a few things that make you shout... "Oh My ZSH!"

### Tmux

[tmux](https://tmux.github.io/) is a terminal multiplexer.

### ZSH

[Zsh](https://www.zsh.org/) is a shell designed for interactive use, although it is also a powerful scripting language.
