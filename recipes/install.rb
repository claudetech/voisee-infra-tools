#
# Cookbook Name:: voisee
# Recipe:: install
#

voisee = node['voisee']

## Make sure to have write permission
%w{log tmp tmp/pids tmp/sockets public/uploads}.each do |path|
  directory File.join(voisee['webapp_path'], path) do
    owner voisee['user']
    group voisee['group']
    mode 0755
    not_if { File.exist?(File.join(voisee['webapp_path'], path)) }
  end
end


## Configure App settings
template File.join(voisee['webapp_path'], "config", "settings.local.yml") do
  source "settings.local.yml.erb"
  user voisee['user']
  group voisee['group']
  variables({
    devise_secret: voisee['devise_secret'],
    facebook_id: voisee['facebook_id'],
    facebook_secret: voisee['facebook_secret']
  })
end

## Configure DB settings
template File.join(voisee['webapp_path'], "config", "database.yml") do
  source "database.yml.erb"
  user voisee['user']
  group voisee['group']
  variables({
    user: voisee['database_user'],
    password: voisee['database_password'],
    host: node['postgresql']['server_host']
  })
end

voisee['environments'].each do |environment|
  ### db:setup
  execute "rake db:setup #{environment}" do
    command <<-EOS
    PATH="/usr/local/bin:$PATH"
    bundle exec rake db:setup RAILS_ENV=#{environment}
    EOS
    cwd voisee['webapp_path']
    user voisee['user']
    group voisee['group']
    action :nothing
    subscribes :run, "postgresql_database[voisee_database]"
  end

  ### db:migrate
  execute "rake db:migrate #{environment}" do
    command <<-EOS
    PATH="/usr/local/bin:$PATH"
    bundle exec rake db:migrate RAILS_ENV=#{environment}
    EOS
    cwd voisee['webapp_path']
    user voisee['user']
    group voisee['group']
    action :nothing
    subscribes :run, "execute[rake db:setup]"
    subscribes :run, "git[clone voisee source]"
  end
end

### db:populate
execute "rake db:populate" do
  command <<-EOS
  PATH="/usr/local/bin:$PATH"
  bundle exec rake db:populate RAILS_ENV=development
  EOS
  cwd voisee['webapp_path']
  user voisee['user']
  group voisee['group']
  action :nothing
  subscribes :run, "execute[rake db:setup development]"
end
