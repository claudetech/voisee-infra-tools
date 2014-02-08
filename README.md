# voisee-cookbook

Necessary recipes to install and configure Voisee webapp.


## Development installation

### Prerequisites

* Virtualbox
* Guest Additions ISO available (if it is not at the default path, uncomment and adapt the `vbguest.iso_path` line in the `Vagrantfile`)
* Vagrant (with the `vagrant` command available in the path)
* NFS if working on OS X or Linux (installed by default on OS X)
* A working `ruby` with the `gem` command in the path

You must not be ask a password when cloning the repository through SSH. Your private key should not have a password or your `ssh-agent` should be configured. If not, the installation will fail afterwards.

### Installation

```
gem install berkshelf
git clone git@github.com:voisee/voisee-dev-tools.git
cd voise-dev-tools
./install-vagrant-plugins.sh
vagrant up --provision
```

The first time, this will probably take a **looong** time, so grab a coffee, take a shower, or whatever.

If you get any error during the above process, please [check the current issues or open a new one][tools-issues].

### Usage

If your box is not started, you will need to start it with

```
vagrant up
```

Then, enter the box and launch the application.

```
vagrant ssh
cd data/voisee-webapp
foreman start
```


[tools-issues]: https://github.com/voisee/voisee-dev-tools/issues
