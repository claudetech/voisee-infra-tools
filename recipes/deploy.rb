#
# Cookbook Name:: voisee
# Recipe:: deploy
#

voisee = node['voisee']

# Set SSH_AUTH_SOCK
if voisee['env'] == 'development'
  include_recipe "root_ssh_agent::env_keep"
end

# Clone webapp
include_recipe "voisee::webapp_clone"

# Install gems
include_recipe "voisee::gems"

# Install app
include_recipe "voisee::install"
