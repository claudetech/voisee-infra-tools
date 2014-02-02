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
end
