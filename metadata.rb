name 'voisee'
maintainer 'Daniel Perez'
maintainer_email 'tuvistavie@gmail.com'
license 'GPL v2'
description 'Installs/Configures Voisee Webapp'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.0.1'

recipe "voisee::default", "Installation"

%w{ yum magic_shell apt ruby_build
    locale phantomjs postgresql
    timezone-ii redisio }.each do |dep|
  depends dep
end

%w{ debian ubuntu centos }.each do |os|
  supports os
end
