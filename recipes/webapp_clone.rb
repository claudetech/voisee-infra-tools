#
# Cookbook Name:: voisee
# Recipe:: webapp_clone
#

voisee = node['voisee']

ssh_home = File.join(voisee['home'], ".ssh")
ssh_paths = [ssh_home]

if voisee['env'] == 'development'
  ssh_home = "/tmp"
  ssh_paths << ssh_home
end

unless voisee['deploy_key'].empty?
  ssh_paths.each do |path|
    template File.join(path, "deploy-ssh-wrapper.sh") do
      source "deploy-ssh-wrapper.erb"
      user voisee['user']
      group voisee['group']
      mode 0755
      variables({
        path: File.join(path)
        })
    end

    file File.join(path, "id_deploy_key") do
      mode 0600
      content voisee['deploy_key']
      user voisee['user']
      group voisee['group']
    end
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
  action :sync
end

if voisee['env'] == 'development' && !voisee['deploy_key'].empty?
  %w{ deploy-ssh-wrapper.sh id_deploy_key }.each do |file|
    file File.join(ssh_home, file) do
      action :delete
    end
  end
end
