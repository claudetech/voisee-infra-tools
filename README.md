# voisee-infra-tools

Necessary recipes to install and configure Voisee webapp.
Also contains a Vagrantfile for development.

## Development installation

### Prerequisites

* [Virtualbox][virtualbox-download]
* [Vagrant][vagrant-download]
* NFS if working on OS X or Linux (installed by default on OS X)
* A working `ruby` with the `gem` command in the path

You must not be ask a password when cloning the repository through SSH. Your private key should not have a password or your `ssh-agent` should be configured. If not, cloning the webapp will fail during the box provisionning.

### Installation

#### Automatic

Just run the following command, and... wait.

```
curl -L http://goo.gl/Y0wQiQ | sh
```

You will be prompted your `root` password when starting the installation. 
The root privileges are only used to mount NFS, nothing else.

Everything will be installed in a `voisee` directory, created in your current directory. 

#### Manual

```
gem install berkshelf
git clone git@github.com:voisee/voisee-infra-tools.git
cd voise-infra-tools
bash install-vagrant-plugins.sh
vagrant up
vagrant provision
```

On OS X, if there is an error, involving NFS, please try the following command.

```
sudo nfsd checkexports
```

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
cd /path/to/voisee-infra-tools
vagrant ssh
cd data/voisee-webapp
bundle exec foreman start
```

You can now visit [http://localhost:3000](http://localhost:3000) and you should see the top page.

You can then edit the files in the webapp data folder normally and it will be synced with the box.

When you are done, run the following command to stop the box.

```
cd /path/to/voisee-infra-tools
vagrant halt
```


[virtualbox-download]: https://www.virtualbox.org/wiki/Downloads
[vagrant-download]: https://www.vagrantup.com/downloads.html
[tools-issues]: https://github.com/voisee/voisee-dev-tools/issues
