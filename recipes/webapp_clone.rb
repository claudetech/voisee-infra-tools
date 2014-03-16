#
# Cookbook Name:: voisee
# Recipe:: webapp_clone
#

voisee = node['voisee']

ssh_home = File.join(voisee['home'], ".ssh")

unless voisee['deploy_key'].empty?
  template File.join(ssh_home, "deploy-ssh-wrapper.sh") do
    source "deploy-ssh-wrapper.erb"
    user voisee['user']
    group voisee['group']
    mode 0755
    variables({
      path: File.join(ssh_home)
    })
    action :create_if_missing
  end

  file File.join(ssh_home, "id_deploy_key") do
    mode 0600
    content voisee['deploy_key']
    user voisee['user']
    group voisee['group']
    action :create_if_missing
  end
end

## Clone the Source
git "clone voisee source" do
  destination voisee['webapp_path']
  repository voisee['webapp_repository']
  revision voisee['revision']
  user voisee['user']
  group voisee['group']
  ssh_wrapper File.join(ssh_home, "deploy-ssh-wrapper.sh") unless voisee['deploy_key'].empty?
  only_if "chmod -R 777 #{File.expand_path('../', ENV['SSH_AUTH_SOCK'])}" if voisee['env'] == 'development'
  not_if { File.exists?(voisee['webapp_path']) }
  action :sync
end
