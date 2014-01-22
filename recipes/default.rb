# encoding: utf-8
# vim: ft=ruby expandtab shiftwidth=2 tabstop=2

#
# Cookbook Name:: concrete5
# Recipe:: default
#
# Copyright 2014, DigitalCube, Inc.
#

include_recipe 'concrete5::swapfile'
include_recipe "apt::default"

packages = %w{git}

packages.each do |pkg|
  package pkg do
    action [:install, :upgrade]
  end
end

include_recipe 'concrete5::apache2'
include_recipe 'concrete5::mysql'

directory node['concrete5']['install_path'] do
  user   node[:apache][:user]
  group  node[:apache][:group]
  mode   0755
  action :create
end

directory node[:concrete5][:cli_dir] do
  recursive true
end

remote_file File.join(node[:concrete5][:cli_dir], 'install-concrete5.php') do
  source node[:concrete5][:cli_url]
  mode 0755
  action :create_if_missing
end

git node['concrete5']['install_path'] do
    repository  node[:concrete5][:git_repository]
    revision    node[:concrete5][:git_revision]
    user        node[:apache][:user]
    group       node[:apache][:group]
    action      :checkout
end

template File.join(node[:concrete5][:install_path], 'config.php') do
  source "config.php.erb"
  owner node[:apache][:user]
  group node[:apache][:group]
  mode "0644"
  variables(
    :dbuser          => node[:concrete5][:db]['user'],
    :dbpass          => node[:concrete5][:db]['pass'],
    :dbname          => node[:concrete5][:db]['name'],
    :dbhost          => node[:concrete5][:db]['host'],
    :admin_email     => node[:concrete5][:admin][:email],
    :admin_pass      => node[:concrete5][:admin][:password],
    :starting_point  => node[:concrete5][:starting_point],
    :target          => File.join(node[:concrete5][:install_path], 'web'),
    :site            => node[:concrete5][:site],
    :core            => File.join(node[:concrete5][:install_path], 'web', 'concrete'),
    :reinstall       => node[:concrete5][:reinstall],
    :demo_username   => node[:concrete5][:demo][:user_name],
    :demo_password   => node[:concrete5][:demo][:password],
    :demo_email      => node[:concrete5][:demo][:email],
  )
  action :create_if_missing
end

bash "concrete5-install" do
  user  node[:apache][:user]
  group node[:apache][:group]
  cwd   node[:concrete5][:install_path]
  code <<-EOH
    #{File.join(node[:concrete5][:cli_dir], 'install-concrete5.php')} \\
    --config=#{File.join(node[:concrete5][:install_path], 'config.php')}
  EOH
end

