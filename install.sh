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

checknfsd() {
  if which nfsd > /dev/null 2>&1; then
    sudo nfsd checkexports
  else
    0
  fi
}

sudo -v
checknfsd

mkdir "$BASE_DIRECTORY" && cd "$BASE_DIRECTORY"
$GIT clone "$REPOSITORY_URL" && cd "$REPOSITORY_NAME"

$GEM install berkshelf
$BASH install-vagrant-plugins.sh

$VAGRANT up
$VAGRANT provision
