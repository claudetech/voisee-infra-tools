# Cookbook Name:: voisee
# Recipe:: packages
#

magic_shell_environment 'PATH' do
  value '/usr/local/bin:/usr/local/bin:/usr/local/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin'
end

include_recipe "apt" if platform?("ubuntu", "debian")
include_recipe "yum::epel" if platform_family?("rhel")
