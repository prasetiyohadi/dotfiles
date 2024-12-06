#!/usr/bin/env bash
set -euo pipefail

APP=$1
PREFIX=.

# # Environment variables template file `${APP}.env`
# APP_BIN=
# APP_VERSION=
# APP_HASH=
# APP_HASH_URL=
# APP_PKG=
# APP_PKG_SRC=
# APP_PKG_SRC_BIN=
# APP_PKG_SRC_COMP=
# APP_PKG_SRC_MAN=
# APP_PKG_TYPE=[APT | BIN | DEB | TARGZ | TARXZ ]
# APP_PKG_URL=

if [ -f "$(dirname $0)/${APP}.env" ]; then
	source "$(dirname $0)/${APP}.env"
else
	echo "Error: $(dirname $0)/${APP}.env not found"
	exit 1
fi

APP_INSTALLED=$(command -v ${APP_BIN} 2>&1 >/dev/null && echo "1" || echo "0")

# Functions

download() {
	if [ "${PREFIX}/${APP_PKG}" != "${PREFIX}/" ]; then
		wget -qO ${PREFIX}/${APP_PKG} ${APP_PKG_URL}
	fi
}

extract() {
	case "${APP_PKG_TYPE}" in
	APT | BIN | DEB)
		echo "This type: ${APP_PKG_TYPE} does not need to be extracted."
		;;
	TARGZ | TARXZ)
		if [ -z "${APP_PKG_SRC}" ]; then
			tar -C ${PREFIX} -xf ${PREFIX}/${APP_PKG} ${APP_BIN}
		else
			tar -C ${PREFIX} -xf ${PREFIX}/${APP_PKG}
		fi
		;;
	*)
		echo "Unknown type: ${APP_PKG_TYPE}"
		;;
	esac
}

checksum() {
	if [ "${PREFIX}/${APP_HASH}" != "${PREFIX}/" ] && [ -f "${PREFIX}/${APP_HASH}" ]; then
		echo "Skipping download. ${APP_HASH} already exists."
	elif [ "${PREFIX}/${APP_HASH}" != "${PREFIX}/" ]; then
		wget -qO ${PREFIX}/${APP_HASH} ${APP_HASH_URL}
	fi
	sha256sum -c ${APP_HASH}
}

install() {
	case "${APP_PKG_TYPE}" in
	APT)
		sudo apt update
		sudo apt install -y ${APP_BIN}
		;;
	DEB)
		sudo dpkg -i ${PREFIX}/${APP_PKG}
		;;
	BIN | TARGZ | TARXZ)
		if [ "${PREFIX}/${APP_BIN}" != "${PREFIX}/" ] && [ -f "${PREFIX}/${APP_BIN}" ]; then
			sudo install -D -m 755 ${PREFIX}/${APP_BIN} /usr/local/bin/${APP_BIN}
		elif [ "${PREFIX}/${APP_PKG_SRC_BIN}" != "${PREFIX}/" ] && [ -d "${PREFIX}/${APP_PKG_SRC_BIN}" ]; then
			sudo install -D -m 755 ${PREFIX}/${APP_PKG_SRC_BIN}/${APP_BIN} /usr/local/bin/${APP_BIN}
		else
			echo "Installation failed. ${APP_BIN} not found."
			exit 1
		fi
		if [ "${PREFIX}/${APP_PKG_SRC_COMP}" != "${PREFIX}/" ] && [ -f "${PREFIX}/${APP_PKG_SRC_COMP}" ]; then
			sudo cp ${PREFIX}/${APP_PKG_SRC_COMP} /usr/local/share/zsh/site-functions
		fi
		if [ "${PREFIX}/${APP_PKG_SRC_MAN}" != "${PREFIX}/" ] && [ -d "${PREFIX}/${APP_PKG_SRC_MAN}" ]; then
			sudo mkdir -p /usr/local/share/man/man1
			sudo rsync -av ${PREFIX}/${APP_PKG_SRC_MAN}/ /usr/local/share/man/man1
		fi
		;;
	*)
		echo "Unknown type: ${APP_PKG_TYPE}"
		;;
	esac
}

cleanup() {
	if [ "${PREFIX}/${APP_BIN}" != "${PREFIX}/" ] && [ -f "${PREFIX}/${APP_BIN}" ]; then
		echo "Cleaning up ${PREFIX}/${APP_BIN}..."
		rm ${PREFIX}/${APP_BIN}
	fi

	if [ "${PREFIX}/${APP_HASH}" != "${PREFIX}/" ] && [ -f "${PREFIX}/${APP_HASH}" ]; then
		echo "Cleaning up ${PREFIX}/${APP_HASH}..."
		rm ${PREFIX}/${APP_HASH}
	fi

	if [ "${PREFIX}/${APP_PKG}" != "${PREFIX}/" ] && [ -f "${PREFIX}/${APP_PKG}" ]; then
		echo "Cleaning up ${PREFIX}/${APP_PKG}..."
		rm ${PREFIX}/${APP_PKG}
	fi

	if [ "${PREFIX}/${APP_PKG_SRC}" != "${PREFIX}/" ] && [ -d "${PREFIX}/${APP_PKG_SRC}" ]; then
		echo "Cleaning up ${PREFIX}/${APP_PKG_SRC}..."
		rm -fr ${PREFIX}/${APP_PKG_SRC}
	fi
}

# Main program

if [ ${APP_INSTALLED} -gt 0 ]; then
	echo "${APP_BIN} is already installed"
else
	if [ -z "${APP_PKG}" ] || [ -z "${APP_PKG_URL}" ]; then
		echo "Skipping download. \${APP_PKG} and \${APP_PKG_URL} are not set."
	elif [ "${PREFIX}/${APP_PKG}" != "${PREFIX}/" ] && [ -f "${PREFIX}/${APP_PKG}" ]; then
		echo "Skipping download. ${APP_PKG} already exists."
	else
		echo "Downloading ${APP_PKG}..."
		download
	fi

	if [ -z "${APP_PKG}" ] || [ -z "${APP_PKG_URL}" ]; then
		echo "Skipping extraction. \${APP_PKG} and \${APP_PKG_URL} are not set."
	elif [ "${PREFIX}/${APP_BIN}" != "${PREFIX}/" ] && [ -f "${PREFIX}/${APP_BIN}" ]; then
		echo "Skipping extraction. ${APP_BIN} already exists."
	elif [ "${PREFIX}/${APP_PKG_SRC}" != "${PREFIX}/" ] && [ -d "${PREFIX}/${APP_PKG_SRC}" ]; then
		echo "Skipping extraction. ${APP_PKG_SRC} already exists."
	else
		echo "Extracting ${APP_PKG}..."
		extract
	fi

	if [ -z "${APP_HASH}" ] || [ ! -z "${APP_HASH_URL}" ]; then
		echo "Skipping checksum. \${APP_HASH} and \${APP_HASH_URL} are not set."
	else
		echo "Verifying checksum..."
		checksum
	fi

	echo "Installing ${APP_BIN}..."
	install

	# Remove temporary files
	cleanup
fi
