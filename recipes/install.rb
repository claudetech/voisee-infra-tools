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

### db:setup
execute "rake db:setup" do
  command <<-EOS
  PATH="/usr/local/bin:$PATH"
  bundle exec rake db:setup RAILS_ENV=#{voisee['env']}
  EOS
  cwd voisee['webapp_path']
  user voisee['user']
  group voisee['group']
  action :run
end

### db:migrate
execute "rake db:migrate" do
  command <<-EOS
  PATH="/usr/local/bin:$PATH"
  bundle exec rake db:migrate RAILS_ENV=#{voisee['env']}
  EOS
  cwd voisee['webapp_path']
  user voisee['user']
  group voisee['group']
  subscribes :run, "execute[rake db:setup]"
end

### db:populate
if voisee['env'] == 'development'
  execute "rake db:populate" do
    command <<-EOS
    PATH="/usr/local/bin:$PATH"
    bundle exec rake db:populate RAILS_ENV=#{voisee['env']}
    EOS
    cwd voisee['webapp_path']
    user voisee['user']
    group voisee['group']
    action :nothing
    subscribes :run, "execute[rake db:setup]"
  end
end
