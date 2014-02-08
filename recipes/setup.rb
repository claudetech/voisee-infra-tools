#
# Cookbook Name:: voisee
# Recipe:: setup
#

# Set locale
include_recipe "locale::default"

# Base packages
include_recipe "voisee::packages"

# Custom ruby install
include_recipe "voisee::ruby"

# Setup Voisee user
include_recipe "voisee::users"

# Create .ssh directory for user
include_recipe "voisee::ssh_dir"

# Setup database
include_recipe "voisee::postgresql_db"
