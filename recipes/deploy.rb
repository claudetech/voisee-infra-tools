#
# Cookbook Name:: voisee
# Recipe:: deploy
#

if node['voisee']['env'] == 'development'
  include_recipe "root_ssh_agent::env_keep"
end

include_recipe "voisee::webapp_clone"
