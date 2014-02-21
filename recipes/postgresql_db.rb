#
# Cookbook Name:: voisee
# Recipe:: postgresql_db
#

postgresql = node['postgresql']
voisee = node['voisee']

# Install postgresql
include_recipe "postgresql::server"
include_recipe "postgresql::server_dev"

## Create a user for Voisee.
pg_user voisee['database_user'] do
  password voisee['database_password']
  # allow rake db:reset in development
  privileges createdb: voisee['env'] == "development"
end

## Create the Voisee database & grant all privileges on database
voisee['environments'].each do |environment|
  pg_database "voisee_#{environment}" do
    encoding postgresql['encoding']
    owner voisee['database_user']
    action :create
  end
end
