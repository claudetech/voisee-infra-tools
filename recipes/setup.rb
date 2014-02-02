#
# Cookbook Name:: voisee
# Recipe:: setup
#

# Install Voisee required packages
include_recipe "voisee::packages"

include_recipe "voisee::postgresql_db"
