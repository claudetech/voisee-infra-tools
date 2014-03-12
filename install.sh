#!/bin/bash

set -e

BASH=/usr/bin/env bash
GEM=gem
GIT=git
VAGRANT=vagrant

REPOSITORY_BASE="git@github.com:voisee/"
REPOSITORY_NAME="voisee-infra-tools"
REPOSITORY_URL="$REPOSITORY_BASE$REPOSITORY_NAME.git"

BASE_DIRECTORY="voisee"

# check environment

for cmd in "vboxmanage" "vagrant" "git" "gem"; do
  if ! eval "which $cmd > /dev/null"; then
    echo "'$cmd' command not found."; exit 1
  fi
done

if which nfsd > /dev/null 2>&1; then
  sudo nfsd checkexports
fi

# Clone and install

mkdir "$BASE_DIRECTORY" && cd "$BASE_DIRECTORY"
$GIT clone "$REPOSITORY_URL" && cd "$REPOSITORY_NAME"

$BASH install-dependencies.sh

$VAGRANT up
$VAGRANT provision
