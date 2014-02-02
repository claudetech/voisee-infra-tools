#
# Cookbook Name:: voisee
# Recipe:: setup
#

# Base packages
include_recipe "voisee::packages"

# Custom ruby install
include_recipe "voisee::ruby"

# Setup Voisee user
include_recipe "voisee::users"

# Setup database
include_recipe "voisee::postgresql_db"
