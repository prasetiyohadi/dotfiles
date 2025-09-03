# Dotfiles

Master your new setup!

Dotfiles are a collection of configuration files and scripts that help you set
up your development environment quickly and efficiently. This repository
contains my personal dotfiles, which I use to configure my systems.

The main tool I use to manage my configuration files is stow. Stow allows me to
create symlinks from my dotfiles repository to the appropriate locations in my home
directory.

Coupled with a few setup scripts, I can easily set up a new machine or restore
my environment. I use Bash scripts to install necessary packages and set up the
ZSH shell which is my current shell of choice.

## Packages

These are the main packages I use in my setup:

- Arkade: A simple CLI for downloading Kubernetes tools and apps.
- Atuin: A modern shell history manager.
- Bat: A cat clone with syntax highlighting and Git integration.
- Devbox: A tool to manage development environments using Nix packages.
- Direnv: An environment switcher for the shell.
- Eza: A modern replacement for 'ls' written in Rust.
- Fzf: A command-line fuzzy finder.
- Git: Version control system to manage my dotfiles repository.
- Nap: A tool to manage your notes and code snippets.
- Neovim: My preferred text editor.
- Pet: A command-line snippet manager.
- Ripgrep: A line-oriented search tool that recursively searches your current.
- Starship: A minimal, blazing-fast, and infinitely customizable prompt for any shell.
- Stow: A symlink manager that helps me manage my dotfiles.
- Tmux: Terminal multiplexer to manage multiple terminal sessions.
- ZSH: A powerful shell that I use as my default shell.
- Zinit: A Zsh plugin manager.
- Zoxide: A smarter cd command.

## Workflow

I mainly use Neovim as my IDE, along with Tmux for terminal multiplexing. After
installing Neovim, I use LazyVim as my configuration framework to enhance my
Neovim experience.

I use Devbox to manage my development environments, allowing me to easily
switch available packages based on the project I'm working on. I can also
install global packages that I use across all projects from the Nix ecosystem.
I also use Arkade to install cloud native tools and applications.

## Setup

To setup a new machine with my dotfiles, follow these steps:

1. Clone this repository to your home directory:

    ```bash
    git clone --depth=1 https://github.com/prasetiyohadi/dotfiles.git ~/dotfiles
    ```

2. Navigate to the dotfiles directory:

    ```bash
    cd ~/dotfiles
    ```

3. Copy the `secrets.env.sample` file to `secrets.env` and fill in any necessary
   environment variables:

    ```bash
    cp secrets.env.sample secrets.env
    ```

4. Run the install script to install the packages and set up the environment:

    ```bash
    ./install.sh
    ```

5. Use the sync script to create symlinks for the dotfiles:

    ```bash
    ./sync.sh
    ```

## To Do

There are still some things I want to improve in my dotfiles setup:

- Automate the configuration of Neovim with LazyVim.
- Fix issues with symlinks creation.
- Curate the list of packages to only include the essentials.
- Add flags to allow installation of optional packages.
- Add pipx to manage global Python packages.
- Try nvm to manage Node.js versions.

## Issues

Currently, there are known issues with the symlinks creation. For example, the
`config.toml` file in the Atuin config directory is always automatically
created by Atuin, which may cause conflicts. To resolve this, you may need to
manually symlink the file after running the sync script.

- Fixing the Atuin config symlink issue:

    ```bash
    ln -frs ~/dotfiles/atuin/config.toml ~/.config/atuin/config.toml
    ```

## Contributing

You are welcome to contribute to this repository by submitting issues or pull
requests. Feel free to suggest improvements or report any bugs you encounter.
Thank you for your interest!
