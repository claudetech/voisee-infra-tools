#
# Cookbook Name:: voisee
# Recipe:: default
#

# Does the setup of Voisee dependencies
include_recipe "voisee::setup"

# Does the configuration and install of Voisee
include_recipe "voisee::deploy"
