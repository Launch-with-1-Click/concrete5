# encoding: utf-8
# vim: ft=ruby expandtab shiftwidth=2 tabstop=2

#
# Cookbook Name:: concrete5
# Recipe:: mysql
#
# Copyright 2014, DigitalCube, Inc.
#

include_recipe "mysql::client"

if node[:concrete5][:db][:host] == "localhost"
  include_recipe "mysql::server"
end

node.set_unless[:concrete5][:db][:pass] = secure_password
node.set_unless[:concrete5][:salt] = secure_password

execute "mysql-install-concrete5" do
  if node['mysql']['server_root_password'] == ''
    command "mysql -h #{node[:concrete5][:db][:host]} -u root < /root/concrete5.sql"
  else
    command "mysql -h #{node[:concrete5][:db][:host]} -u root -p#{node['mysql']['server_root_password']} < /root/concrete5.sql"
  end
  action :nothing
end

template "/root/concrete5.sql" do
  source "concrete5.sql.erb"
  owner "root"
  group "root"
  mode "0600"
  variables(
    :dbuser => node[:concrete5][:db]['user'],
    :dbpass => node[:concrete5][:db]['pass'],
    :dbname => node[:concrete5][:db]['name'],
    :dbhost => node[:concrete5][:db]['host']
  )
  notifies :run, "execute[mysql-install-concrete5]", :immediately
end

