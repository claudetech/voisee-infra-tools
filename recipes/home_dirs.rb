#
# Cookbook Name:: voisee
# Recipe:: home_dir
#

voisee = node['voisee']

directory File.join(voisee['home'], '.ssh') do
  owner voisee['user']
  group voisee['group']
  mode 00755
  action :create
end
