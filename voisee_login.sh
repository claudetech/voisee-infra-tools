#!/bin/sh

if [ ! -f /home/voisee/.profile ]; then
  echo 'echo You are now logged in as voisee. To get sudo privileges please exit to become the vagrant user' | su voisee -c 'cat >> /home/voisee/.profile'
fi

cat /home/vagrant/.bashrc | grep --quiet 'sudo su - voisee' || echo 'sudo su - voisee' >> /home/vagrant/.bashrc

