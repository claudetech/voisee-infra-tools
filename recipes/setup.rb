#
# Cookbook Name:: voisee
# Recipe:: setup
#

voisee = node['voisee']

# Set locale
include_recipe "locale::default"

# Base packages
include_recipe "voisee::packages"

# Custom ruby install
include_recipe "voisee::ruby"

# Setup Voisee user
include_recipe "voisee::users"

# Create .ssh directory for user
include_recipe "voisee::home_dirs"

# Setup database
include_recipe "voisee::postgresql_db"

# PhantomJS
unless voisee['env'] == 'production'
  include_recipe "phantomjs"
end
