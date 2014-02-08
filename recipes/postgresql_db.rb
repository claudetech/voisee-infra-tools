#
# Cookbook Name:: voisee
# Recipe:: postgresql_db
#


postgresql = node['postgresql']
voisee = node['voisee']

# Install postgresql
include_recipe "postgresql::server"
include_recipe "database::postgresql"

postgresql_connection = {
  host: postgresql['server_host'],
  username: 'postgres',
  password: postgresql['password']['postgres']
}

## Create a user for Voisee.
postgresql_database_user voisee['database_user'] do
  connection postgresql_connection
  password voisee['database_password']
  action :create
end

## Create the Voisee database & grant all privileges on database
voisee['environments'].each do |environment|
  postgresql_database "voisee_database" do
    database_name "voisee_#{environment}"
    connection postgresql_connection
    encoding postgresql['encoding']
    owner voisee['database_user'] if voisee['env'] != 'production'
    action :create
  end

  postgresql_database_user voisee['database_user'] do
    connection postgresql_connection
    database_name "voisee_#{environment}"
    password voisee['database_password']
    action :grant
  end
end
