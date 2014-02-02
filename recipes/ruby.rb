#
# Cookbook Name:: voisee
# Recipe:: ruby
#

voisee = node['voisee']

include_recipe "ruby_build"

ruby_build_ruby voisee['ruby'] do
  prefix_path "/usr/local/"
end

## Install the Bundler Gem:
gem_package "bundler" do
  gem_binary "/usr/local/bin/gem"
  options "--no-ri --no-rdoc"
end
