#
# Cookbook Name:: voisee
# Recipe:: users
#

# Creates user and group for Voisee

voisee = node['voisee']

group voisee['group'] do
  gid voisee['user_gid']
end

user voisee['user'] do
  comment "voisee user"
  home voisee['home']
  shell "/bin/bash"
  uid voisee['user_uid']
  gid voisee['group']
  supports manage_home: true
end

user voisee['user'] do
  action :lock
end
