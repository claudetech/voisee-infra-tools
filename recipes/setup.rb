#
# Cookbook Name:: voisee
# Recipe:: setup
#
# This recipe is used for AWS OpsWorks setup section
# Any change must be tested against AWS OpsWorks stack

# Install Voisee required packages
include_recipe "voisee::packages"
