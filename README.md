# voisee-cookbook

Necessary recipes to install and configure Voisee webapp.

## Development installation

### Prerequisites

* [Virtualbox][virtualbox-download]
* [Vagrant][vagrant-download]
* NFS if working on OS X or Linux (installed by default on OS X)
* A working `ruby` with the `gem` command in the path

You must not be ask a password when cloning the repository through SSH. Your private key should not have a password or your `ssh-agent` should be configured. If not, cloning the webapp will fail during the box provisionning.

### Installation

```
gem install berkshelf
git clone git@github.com:voisee/voisee-dev-tools.git
cd voise-dev-tools
./install-vagrant-plugins.sh
vagrant up
vagrant provision
```

Please **DO NOT** use `vagrant up --provision` instead for now.

The first time, `vagrant provision` will take a **looong** time, so grab a coffee or go and take a shower.

If you get any error during the above process, please [check the current issues or open a new one][tools-issues].

### Usage

**Important** The data folder where will be placed the webapp git repository is by default at `../voisee_data`. You can change it in the Vagrantfile or by setting the `DATA_DIR` environment variable.

If your box is not started, you will need to start it with

```
vagrant up
```

Then, enter the box and launch the application.

```
vagrant ssh
cd data/voisee-webapp
bundle exec foreman start
```

You can now visit [http://localhost:3000](http://localhost:3000) and you should see the top page.


[virtualbox-download]: https://www.virtualbox.org/wiki/Downloads
[vagrant-download]: https://www.vagrantup.com/downloads.html
[tools-issues]: https://github.com/voisee/voisee-dev-tools/issues
