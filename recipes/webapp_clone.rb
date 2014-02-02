#
# Cookbook Name:: voisee
# Recipe:: webapp_clone
#

voisee = node['voisee']

unless voisee['deploy_key'].empty?
  template File.join(voisee['home'], ".ssh", "deploy-ssh-wrapper.sh") do
    source "deploy-ssh-wrapper.erb"
    user voisee['user']
    group voisee['group']
    mode 0755
    variables({
      path: File.join(voisee['home'], ".ssh")
    })
  end

  file File.join(voisee['home'], ".ssh", "id_deploy_key") do
    mode 0600
    content voisee['deploy_key']
    user voisee['user']
    group voisee['group']
  end
end

## Clone the Source
git "clone voisee source" do
  destination voisee['webapp_path']
  repository voisee['webapp_repository']
  revision voisee['revision']
  user voisee['user']
  group voisee['group']
  ssh_wrapper File.join(voisee['home'], ".ssh", "deploy-ssh-wrapper.sh") unless voisee['deploy_key'].empty?
  action :sync
end
