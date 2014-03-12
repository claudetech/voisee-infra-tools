#!/bin/sh

set -e


if `gem list | grep berkshelf > /dev/null`; then
  echo 'berkshelf gem already installed, skipping.'
else
  echo 'Installing berkshelf gem...'
  gem install berkshelf
fi

for plugin in "vagrant-omnibus" "vagrant-bindfs" "vagrant-berkshelf" "vagrant-vbguest" "vagrant-triggers"; do
  if eval "vagrant plugin list | grep $plugin > /dev/null"; then
    echo "$plugin already installed, skipping."
  else
    echo "Installing $plugin..."
    vagrant plugin install $plugin
  fi
done
