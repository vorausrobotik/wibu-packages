#!/bin/bash

: '
1. setup your EMAIL env var to match the one of your targeted gpg key
2. place the new deb files in the package directory
3. run this script and provide your credentials once asked for it
'

set -euo pipefail

BASE_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PACKAGE_DIR="${BASE_PATH}/ubuntu/"

if [[ -z "${EMAIL:-}" ]]; then
    echo "Error: The EMAIL environment variable is not set." >&2
    exit 1
fi

if git status --porcelain "$PACKAGE_DIR" | grep -q -v '\.deb'; then
  echo "Error: The package directory is not clean (excluding .deb files)."
  echo "Please commit or stash your changes in $PACKAGE_DIR before proceeding."
  exit 1
fi

for cmd in dpkg-scanpackages apt-ftparchive gpg gzip sed; do
    if ! command -v "$cmd" &>/dev/null; then
        echo "Error: Required command '$cmd' is not installed." >&2
        exit 1
    fi
done

dpkg-scanpackages --multiversion "$PACKAGE_DIR" | sed "s|$PACKAGE_DIR|./|" > "${PACKAGE_DIR}Packages"
gzip -k -f "${PACKAGE_DIR}Packages" --no-name

apt-ftparchive release "$PACKAGE_DIR" > "${PACKAGE_DIR}Release"
gpg --default-key "${EMAIL}" -abs -o "${PACKAGE_DIR}Release.gpg" "${PACKAGE_DIR}Release"
gpg --default-key "${EMAIL}" --clearsign -o "${PACKAGE_DIR}InRelease" "${PACKAGE_DIR}Release"
