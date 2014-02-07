#
# Cookbook Name:: voisee
# Recipe:: deploy
#

voisee = node['voisee']

if voisee['env'] == 'development'
  include_recipe "root_ssh_agent::env_keep"
end

include_recipe "voisee::webapp_clone"
