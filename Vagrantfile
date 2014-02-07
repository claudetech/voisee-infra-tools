MEMORY = ENV['VOISEE_VAGRANT_MEMORY'] || '1536'
CORES = ENV['VOISEE_VAGRANT_CORES'] || '2'

Vagrant.configure("2") do |config|
  config.vm.hostname = "voisee-dev"

  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"
  config.vm.network :private_network, ip: "192.168.3.4"

  config.vm.network :forwarded_port, guest: 3000, host: 3000
  config.vm.network :forwarded_port, guest: 80, host: 8080

  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.synced_folder "./home_voisee", "/voisee-nfs", nfs: true
  config.bindfs.bind_folder "/voisee-nfs", "/home/voisee/data", owner: "1111", group: "1111", :'create-as-user' => true, :perms => "u=rwx:g=rx:o=rx", :'create-with-perms' => "u=rwx:g=rx:o=rx", :'chown-ignore' => true, :'chgrp-ignore' => true, :'chmod-normal' => true

  config.omnibus.chef_version = "11.4.4"

  config.berkshelf.enabled = true

  config.ssh.forward_agent = true

  config.vm.provision :chef_solo do |chef|
    chef.run_list = [
      "voisee::default"
    ]
    chef.json = {
      'voisee' => {
        'env' => 'development',
        'user_uid' => 1111,
        'user_gid' => 1111,
        'deploy_key' => File.read(File.join(ENV['HOME'], ".ssh/id_rsa"))
      }
    }

    # chef.arguments = '-l debug'
  end
end
