# Package
if platform_family?("rhel")
  packages = %w{
    libicu-devel
    libxslt-devel
    libyaml-devel
    libxml2-devel
    gdbm-devel
    libffi-devel
    zlib-devel
    libyaml-devel
    readline-devel
    curl-devel
    openssl-devel
    pcre-devel
    git
    gcc-c++
    ImageMagick-devel
    ImageMagick
    zsh
  }
else
  packages = %w{
    build-essential
    zlib1g-dev
    libyaml-dev
    libssl-dev
    libgdbm-dev
    libreadline-dev
    libncurses5-dev
    imagemagick
    libffi-dev
    curl
    git
    openssh-server
    checkinstall
    libxml2-dev
    libxslt-dev
    libcurl4-openssl-dev
    libicu-dev
    python-docutils
    logrotate
    vim
    curl
    wget
    checkinstall
    zsh
  }
end

default['voisee']['packages'] = packages
default['voisee']['ruby'] = "2.1.0"

default['voisee']['webapp_repository'] = 'git@github.com:voisee/voisee-webapp.git'
default['voisee']['deploy_key'] = ''

# Postgresql

default['postgresql']['password']['postgres'] = "psqlpass"
default['postgresql']['server_host'] = "localhost"
default['postgresql']['encoding'] = "UTF-8"
default['postgresql']['initdb_options'] = "-E '#{default['postgresql']['encoding']}'"

default['tz'] = 'Asia/Tokyo'

default['voisee']['database_user'] = "voisee"
default['voisee']['database_password'] = "datapass"

default['voisee']['env'] = "production"

# User
default['voisee']['user'] = "voisee"
default['voisee']['group'] = "voisee"
if default['voisee']['env'] == "production"
  default['voise']['shell'] = '/bin/bash'
else
  default['voise']['shell'] = '/bin/zsh'
end
default['voisee']['user_uid'] = nil
default['voisee']['user_gid'] = nil
default['voisee']['home'] = "/home/voisee"
default['voisee']['data_home'] = "#{default['voisee']['home']}/data"

default['voisee']['devise_secret'] = 'foobar'

default['voisee']['webapp_path'] = "#{default['voisee']['data_home']}/voisee-webapp"

default['voisee']['bundle_install'] = "SSL_CERT_FILE=/opt/local/etc/certs/cacert.pem bundle install"
if voisee['env'] == 'production'
  default['voisee']['bundle_install'] <<= " --path=.bundle --deployment"
else
  default['voisee']['bundle_install'] <<= " --path=#{default['voisee']['home']}/.bundle"
end

# Facebook
default['voisee']['facebook_id'] = 'facebook_id'
default['voisee']['facebook_secret'] = 'facebook_secret'


# Setup environments
if node['voisee']['env'] == "development"
  default['voisee']['port'] = "3000"
  default['voisee']['url'] = "http://localhost:3000/"
  default['voisee']['revision'] = "master"
  default['voisee']['environments'] = %w{development test}
  default['voisee']['ssh_port'] = "2222"
else
  default['voisee']['environments'] = %w{production}
  default['voisee']['url'] = "http://localhost:80/"
  default['voisee']['revision'] = "master"
  default['voisee']['port'] = "80"
  default['voisee']['ssh_port'] = "22"
end
