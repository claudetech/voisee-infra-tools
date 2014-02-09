#
# Cookbook Name:: voisee
# Recipe:: users
#

# Creates user and group for Voisee

voisee = node['voisee']

## Creates group Voisee
group voisee['group'] do
  gid voisee['user_gid']
end

## Creates user Voisee
user voisee['user'] do
  comment "voisee user"
  home voisee['home']
  shell "/bin/bash"
  uid voisee['user_uid']
  gid voisee['group']
  supports manage_home: true
end

directory voisee['home'] do
  owner voisee['user']
  group voisee['group']
  recursive true
  mode 0755
end


user voisee['user'] do
  action :lock
end
