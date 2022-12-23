#!/usr/bin/env bash
set -euo pipefail

OS=${OSTYPE:-'linux-gnu'}
OS_ID=""
[ -f "/etc/os-release" ] && source /etc/os-release && OS_ID=$ID
OS_TYPE=$(echo "$OS" | tr -d ".[:digit:]")
OS_TYPE_DARWIN=darwin
OS_TYPE_LINUX_AMD64=linux-gnu
OS_TYPE_LINUX_ARM=linux-gnueabihf
HAS_BREW="$(type "brew" &>/dev/null && echo true || echo false)"
HAS_GIT="$(type "git" &>/dev/null && echo true || echo false)"
APPS="fzf nvim tmux"
OMZ_PATH=~/.oh-my-zsh
TPM_PATH=~/.tmux/plugins/tpm
ZSHRC=~/.zshrc

# setup asdf
setup_asdf() {
	VER=0.10.2
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
			# install package dependencies
			# crate: jless
			sudo apt-get install -y libxcb-render0-dev libxcb-shape0-dev libxcb-xfixes0-dev
			# pip: diagrams
			sudo apt-get install -y graphviz
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

# install fzf in macos
install_fzf_darwin() {
	brew install fzf
}

# install fzf in linux
install_fzf_linux() {
	if [ "$OS_ID" == "debian" ] || [ "$OS_ID" == "ubuntu" ] || [ "$OS_ID" == "pop" ]; then
		sudo apt-get update
		sudo apt-get install -y fzf
	elif [ "$OS_ID" == "centos" ] || [ "$OS_ID" == "fedora" ]; then
		sudo dnf install -y fzf
	fi
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

# install neovim in macos
install_nvim_darwin() {
	brew install neovim
}

# install neovim in linux
install_nvim_linux() {
	if [ "$OS_ID" == "debian" ] || [ "$OS_ID" == "ubuntu" ] || [ "$OS_ID" == "pop" ]; then
		# remove vim
		sudo apt-get purge -y vim-tiny vim-runtime vim-common
		# install neovim v0.8.1
		SRC=nvim.appimage
		VER=0.8.1
		URL=https://github.com/neovim/neovim/releases/download/v$VER/$SRC
		wget -O /tmp/$SRC $URL
		wget -O /tmp/$SRC.sha256sum $URL.sha256sum
		echo "$(awk '{print $1}' /tmp/$SRC.sha256sum)" /tmp/$SRC >/tmp/$SRC.sum
		sha256sum -c /tmp/$SRC.sum
		chmod u+x /tmp/$SRC
		sudo install -m 755 /tmp/$SRC /usr/bin/nvim
		sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 900
		sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 900
		rm /tmp/$SRC.sha256sum /tmp/$SRC.sum
	elif [ "$OS_ID" == "centos" ] || [ "$OS_ID" == "fedora" ]; then
		# install neovim
		sudo dnf install --assumeyes neovim
		sudo alternatives --install /usr/bin/vi vi /usr/bin/nvim 900
		sudo alternatives --install /usr/bin/vim vim /usr/bin/nvim 900
	fi
}

# setup neovim configuration
setup_nvim() {
	pushd "$(dirname "$0")"
	if [ -e "$HOME/.config/nvim" ]; then mv -f "$HOME/.config/nvim"{,-"$(date +%s)"}; fi
	ln -frs "$(pwd)/config/nvim" "$HOME/.config/nvim"
	popd
}

# install oh-my-zsh
install_omz() {
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

# install oh-my-zsh custom plugins
install_omz_plugin() {
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

# install oh-my-zsh custom themes
install_omz_theme() {
	pushd "$(dirname "$0")"
	ln -frs "$(pwd)/zsh/catalyst.zsh-theme" $OMZ_PATH/custom/themes/catalyst.zsh-theme
	popd
	# install powerlevel10k
	rm -fr "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
}

# setup oh-my-zsh
setup_omz() {
	install_omz
	install_omz_plugin
	install_omz_theme
}

# install tmux plugins manager
install_tmux_plugin_manager() {
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
			install_tmux_plugin_manager
		else
			echo "Tmux plugins manager installation cancelled."
		fi
	else
		install_tmux_plugin_manager
	fi
}

# setup tmux
setup_tmux() {
	pushd "$(dirname "$0")"
	ln -frs "$(pwd)/tmux.conf" "$HOME/.tmux.conf"
	popd
	setup_tmux_plugin_manager
}

# install tmux and powerline in macos
install_tmux_darwin() {
	brew install python tmux
	pip3 install powerline-status psutil
}

# install tmux and powerline in linux
install_tmux_linux() {
	if [ -f /etc/debian_version ]; then
		sudo apt-get update
		sudo apt-get install -y powerline tmux
	elif [ -f /etc/redhat-release ]; then
		sudo dnf install --assumeyes python3-pip tmux
		sudo pip3 install powerline-status
	fi
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

# installation for macos
setup_darwin() {
	for APP in $APPS; do
		echo "This script will install $APP using brew."
		if [ ! "$HAS_BREW" == "true" ]; then
			echo "Homebrew must be installed!"
		else
			"install_${APP}_darwin"
		fi
	done
}

# installation for linux
setup_linux() {
	for APP in $APPS; do
		echo "This script will install $APP."
		HAS_APP="$(type "$APP" &>/dev/null && echo true || echo false)"
		if [ "$HAS_APP" == "true" ]; then
			read -p "$APP already exists. Replace[yn]? " -n 1 -r
			echo
			if [[ "$REPLY" =~ ^[Yy]$ ]]; then
				"install_${APP}_linux"
			else
				echo "$APP installation cancelled."
			fi
		else
			"install_${APP}_linux"
		fi
	done
}

# main function
main() {
	if [ "$OS_TYPE" == "$OS_TYPE_DARWIN" ]; then
		setup_darwin
	elif [ "$OS_TYPE" == "$OS_TYPE_LINUX_AMD64" ] ||
		[ "$OS_TYPE" == "$OS_TYPE_LINUX_ARM" ]; then
		setup_linux
	fi
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
