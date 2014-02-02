#
# Cookbook Name:: voisee
# Recipe:: postgresql_db
#

# Install postgresql
include_recipe "postgresql::server"
include_recipe "database::postgresql"
