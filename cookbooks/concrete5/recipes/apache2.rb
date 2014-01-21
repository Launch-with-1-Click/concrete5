# encoding: utf-8
# vim: ft=ruby expandtab shiftwidth=2 tabstop=2

#
# Cookbook Name:: concrete5
# Recipe:: apache2
#
# Copyright 2014, DigitalCube, Inc.
#

include_recipe %w{apache2 apache2::mod_php5 apache2::mod_rewrite apache2::mod_expires}
include_recipe %w{php php::module_mysql php::module_gd php::module_curl php::module_curl}

#template "/etc/php5/apache2/conf.d/concrete5.ini" do
#  source "concrete5.ini.erb"
#  owner "root"
#  group "root"
#  mode "0600"
#  notifies :restart, "service[apache2]"
#end

directory node[:concrete5][:install_path] do
  user   node[:apache][:user]
  group  node[:apache][:group]
  mode   0755
  action :create
end

web_app "concrete5" do
  template "concrete5.conf.erb"
  docroot File.join(node[:concrete5][:install_path], 'web')
  server_name node[:fqdn]
  notifies :restart, "service[apache2]"
end

