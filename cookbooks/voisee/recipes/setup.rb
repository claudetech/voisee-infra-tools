#
# Cookbook Name:: voisee
# Recipe:: setup
#

include_recipe "voisee::packages"

include_recipe "voisee::ruby"

include_recipe "voisee::postgresql_db"
