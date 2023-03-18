#!/usr/bin/env bash
set -euo pipefail

OS=${OSTYPE:-'linux-gnu'}
OS_ID=""
[ -f "/etc/os-release" ] && source /etc/os-release && OS_ID=$ID
OS_TYPE=$(echo "$OS" | tr -d ".[:digit:]")
OS_TYPE_DARWIN=darwin
OS_TYPE_LINUX_AMD64=linux-gnu
OS_TYPE_LINUX_ARM=linux-gnueabihf
HAS_GIT="$(type "git" &>/dev/null && echo true || echo false)"
OMZ_PATH=~/.oh-my-zsh
TPM_PATH=~/.tmux/plugins/tpm
ZSHRC=~/.zshrc

# setup asdf
setup_asdf() {
	VER=0.11.1
	if [ "$OS_TYPE" == "$OS_TYPE_DARWIN" ]; then
		echo "Add ASDF prerequisites for macos"
	elif [ "$OS_TYPE" == "$OS_TYPE_LINUX_AMD64" ]; then
		if [ "$OS_ID" == "debian" ] || [ "$OS_ID" == "ubuntu" ] || [ "$OS_ID" == "pop" ]; then
			# debian based
			sudo apt-get update
			sudo apt-get install -y make build-essential libssl-dev zlib1g-dev \
				libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
				libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev \
				libffi-dev liblzma-dev dirmngr gpg gawk autoconf gettext libcurl4-openssl-dev
			# utilities
			# https://github.com/johnkerl/miller
			sudo apt-get install -y miller
			# install package dependencies
			# crate: jless
			sudo apt-get install -y libxcb-render0-dev libxcb-shape0-dev libxcb-xfixes0-dev
			# pip: diagrams
			sudo apt-get install -y graphviz
			# tmux: byacc
			sudo apt-get install -y byacc
			# neovim: gdu luacheck
			sudo apt-get install -y gdu luarocks
		elif [ "$OS_ID" == "centos" ] || [ "$OS_ID" == "fedora" ]; then
			# fedora 22 and above
			sudo dnf install -y make gcc zlib-devel bzip2 bzip2-devel \
				readline-devel sqlite sqlite-devel openssl-devel tk-devel \
				libffi-devel xz-devel
			# ueberzug
			sudo dnf install -y libXext-devel
		fi
	fi
	if [ ! -e "$HOME/.asdf" ]; then
		git clone https://github.com/asdf-vm/asdf.git "$HOME/.asdf" --branch "v$VER"
	fi
	pushd "$(dirname "$0")"
	ln -frs "$(pwd)/asdfrc" "$HOME/.asdfrc"
	ln -frs "$(pwd)/default-cargo-crates" "$HOME/.default-cargo-crates"
	ln -frs "$(pwd)/default-cloud-sdk-components" "$HOME/.default-cloud-sdk-components"
	ln -frs "$(pwd)/default-golang-pkgs" "$HOME/.default-golang-pkgs"
	ln -frs "$(pwd)/default-krew-plugins" "$HOME/.default-krew-plugins"
	ln -frs "$(pwd)/default-npm-packages" "$HOME/.default-npm-packages"
	ln -frs "$(pwd)/default-python-packages" "$HOME/.default-python-packages"
	ln -frs "$(pwd)/tool-versions" "$HOME/.tool-versions"
	popd
	# shellcheck disable=SC1091
	. "$HOME/.asdf/asdf.sh"
	while read -r plugin; do asdf plugin add "$(echo "$plugin" | awk '{print $1}')" || true; done <"$HOME/.tool-versions"
	eval "asdf install $(grep python "$HOME/.tool-versions" | tr -d '\n')"
	eval "asdf global $(grep python "$HOME/.tool-versions" | tr -d '\n')"
	asdf install || true
}

# setup fzf configuration
setup_fzf() {
	pushd "$(dirname "$0")"
	ln -frs "$(pwd)/zsh/fzf.zsh" "$HOME/.fzf.zsh"
	popd
}

# setup git configuration
setup_git() {
	pushd "$(dirname "$0")"
	ln -frs "$(pwd)/gitconfig" "$HOME/.gitconfig"
	popd
}

# setup neovim configuration
setup_nvim() {
	pushd "$(dirname "$0")"
	if [ -e "$HOME/.config/nvim" ]; then mv -f "$HOME/.config/nvim"{,-"$(date +%s)"}; fi
	ln -frs "$(pwd)/config/nvim" "$HOME/.config/nvim"
	popd
}

# clone oh-my-zsh
clone_omz() {
	if [ ! "$HAS_GIT" == "true" ]; then
		echo "Git must be installed!"
	else
		if [ -d $OMZ_PATH ]; then
			(cd $OMZ_PATH && git pull)
		else
			git clone https://github.com/robbyrussell/oh-my-zsh.git $OMZ_PATH
		fi
	fi
}

# clone oh-my-zsh custom plugins
clone_omz_plugin() {
	if [ ! "$HAS_GIT" == "true" ]; then
		echo "Git must be installed!"
	else
		if [ -d $OMZ_PATH/custom/plugins/zsh-autosuggestions ]; then
			(cd $OMZ_PATH/custom/plugins/zsh-autosuggestions && git pull)
		else
			git clone https://github.com/zsh-users/zsh-autosuggestions \
				$OMZ_PATH/custom/plugins/zsh-autosuggestions
		fi
		if [ -d $OMZ_PATH/custom/plugins/zsh-syntax-highlighting ]; then
			(cd $OMZ_PATH/custom/plugins/zsh-syntax-highlighting && git pull)
		else
			git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
				$OMZ_PATH/custom/plugins/zsh-syntax-highlighting
		fi
	fi
}

# setup oh-my-zsh custom themes
setup_omz_theme() {
	pushd "$(dirname "$0")"
	ln -frs "$(pwd)/zsh/catalyst.zsh-theme" $OMZ_PATH/custom/themes/catalyst.zsh-theme
	popd
	# install powerlevel10k
	rm -fr "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
}

# setup oh-my-zsh
setup_omz() {
	clone_omz
	clone_omz_plugin
	setup_omz_theme
}

# clone tmux plugins manager
clone_tmux_plugin_manager() {
	if [ ! "$HAS_GIT" == "true" ]; then
		echo "Git must be installed!"
	else
		git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
	fi
}

# setup tmux plugins manager
setup_tmux_plugin_manager() {
	if [ -d "$TPM_PATH" ]; then
		read -p "$TPM_PATH already exists. Replace[yn]? " -n 1 -r
		echo
		if [[ "$REPLY" =~ ^[Yy]$ ]]; then
			rm -r $TPM_PATH
			clone_tmux_plugin_manager
		else
			echo "Tmux plugins manager installation cancelled."
		fi
	else
		clone_tmux_plugin_manager
	fi
}

# setup tmux
setup_tmux() {
	pushd "$(dirname "$0")"
	ln -frs "$(pwd)/tmux.conf" "$HOME/.tmux.conf"
	popd
	setup_tmux_plugin_manager
}

# setup yamllint configuration
setup_yamllint() {
	pushd "$(dirname "$0")"
	if [ -e "$HOME/.config/yamllint" ]; then mv -f "$HOME/.config/yamllint"{,-"$(date +%s)"}; fi
	ln -frs "$(pwd)/config/yamllint" "$HOME/.config/yamllint"
	popd
}

# setup .zshrc
setup_zshrc() {
	pushd "$(dirname "$0")"
	# powerlevel10k configuration
	ln -frs "$(pwd)/zsh/p10k.zsh" "$HOME/.p10k.zsh"
	ln -frs "$(pwd)/zsh/zprofile" "$HOME/.zprofile"
	if [ "$OS_TYPE" == "$OS_TYPE_DARWIN" ]; then
		ln -frs "$(pwd)/zsh/zshrc.macos" $ZSHRC
	elif [ "$OS_TYPE" == "$OS_TYPE_LINUX_AMD64" ]; then
		if [ "$OS_ID" == "debian" ] || [ "$OS_ID" == "ubuntu" ] || [ "$OS_ID" == "pop" ]; then
			ln -frs "$(pwd)/zsh/zshrc.debian" $ZSHRC
		elif [ "$OS_ID" == "centos" ] || [ "$OS_ID" == "fedora" ]; then
			ln -frs "$(pwd)/zsh/zshrc.redhat" $ZSHRC
		fi
	elif [ "$OS_TYPE" == "$OS_TYPE_LINUX_ARM" ]; then
		if [ "$OS_ID" == "debian" ] || [ "$OS_ID" == "ubuntu" ]; then
			ln -frs "$(pwd)/zsh/zshrc.raspbian" $ZSHRC
		fi
	fi
	popd
}

# main function
main() {
	setup_asdf
	setup_fzf
	setup_git
	setup_nvim
	setup_omz
	setup_tmux
	setup_yamllint
	setup_zshrc
}

main
