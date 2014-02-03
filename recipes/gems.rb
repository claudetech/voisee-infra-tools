#
# Cookbook Name:: voisee
# Recipe:: gems
#

voisee = node['voisee']

execute "Update rubygems" do
  command "gem update --system"
end

## Install Gems without ri and rdoc
template File.join(voisee['home'], ".gemrc") do
  source "gemrc.erb"
  user voisee['user']
  group voisee['group']
  action :create
end

bundle_without = []
case voisee['env']
when 'production'
  bundle_without << 'development'
  bundle_without << 'test'
else
  bundle_without << 'production'
end

execute "bundle install" do
  command <<-EOS
  PATH="/usr/local/bin:$PATH"
  #{voisee['bundle_install']} --without #{bundle_without.join(" ")}
  EOS
  cwd voisee['path']
  user voisee['user']
  group voisee['group']
end
