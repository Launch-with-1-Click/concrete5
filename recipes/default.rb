# encoding: utf-8
# vim: ft=ruby expandtab shiftwidth=2 tabstop=2

#
# Cookbook Name:: concrete5
# Recipe:: default
#
# Copyright 2014, DigitalCube, Inc.
#

require 'shellwords'


include_recipe 'concrete5::swapfile'
include_recipe "apt::default"
include_recipe "nodejs::nodejs_from_package"
include_recipe "nodejs::npm"


packages = %w{git curl}

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


directory "/var/lib/php/session/" do
  user   "root"
  group  node[:apache][:group]
  recursive true
  action :create
  mode   0770
end

directory node[:concrete5][:cli_dir] do
  recursive true
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
    :locale          => node[:concrete5][:locale],
    :reinstall       => node[:concrete5][:reinstall],
    :demo_username   => node[:concrete5][:demo][:user_name],
    :demo_password   => node[:concrete5][:demo][:password],
    :demo_email      => node[:concrete5][:demo][:email],
  )
  action :create_if_missing
end


#
# concrete5 5.7
#

if node[:concrete5][:git_revision].to_f >= 5.7


  #
  # Setup composer
  #

  directory File.join(node[:concrete5][:cli_dir], 'composer') do
    recursive true
  end

  execute node[:concrete5][:composer][:install] do
    user  "root"
    group "root"
    cwd   File.join(node[:concrete5][:cli_dir], 'composer')
  end

  link node[:concrete5][:composer][:link] do
    to File.join(node[:concrete5][:cli_dir], 'composer/composer.phar')
  end

  directory "/home/" + node[:apache][:user] + "/.composer"  do
    user  node[:apache][:user]
    group node[:apache][:group]
    recursive true
  end

  execute "composer-install" do
    user  node[:apache][:user]
    group node[:apache][:group]
    cwd File.join(node[:concrete5][:install_path], 'web/concrete')
    command "composer install"
  end


  #
  # Download Translation
  #

  if !node[:concrete5][:locale].empty? && node[:concrete5][:locale] != "en_US"

    [
      File.join(node[:concrete5][:install_path], 'web/application/languages'),
      File.join(node[:concrete5][:install_path], 'web/application/languages', node[:concrete5][:locale]),
      File.join(node[:concrete5][:install_path], 'web/application/languages', node[:concrete5][:locale], "LC_MESSAGES" )
    ].each do |path|
      directory path do
        user   node[:apache][:user]
        group  node[:apache][:group]
        mode   0755
        action :create
      end
    end

    remote_file File.join(node[:concrete5][:install_path], 'web/application/languages', node[:concrete5][:locale], "LC_MESSAGES", "messages.mo" ) do
      source File.join(node[:concrete5][:translations_repo_dir], "#{node[:concrete5][:locale]}.mo")
      mode 0644
      action :create
    end

  end


  #
  # Setup npm
  #

  directory "/home/" + node[:apache][:user] + "/.npm"  do
    user  node[:apache][:user]
    group node[:apache][:group]
    recursive true
    action :create
    mode 0755
  end

  execute "npm-update" do
    user   "root"
    group  "root"
    command "npm -g install npm@latest"
  end


  #
  # Setup grunt
  #

  execute "grunt-install" do
    user   "root"
    group  "root"
    command "npm install grunt-cli -g"
  end

  execute "npm-install" do
    user  node[:apache][:user]
    group node[:apache][:group]
    environment 'HOME' => '/home/' + node[:apache][:user]
    cwd File.join(node[:concrete5][:install_path], 'build')
    command "npm install"
  end

end # end for 5.7



#
# execute install script concrete5
#

bash "concrete5-install" do
  user  node[:apache][:user]
  group node[:apache][:group]
  cwd   node[:concrete5][:install_path]
  code <<-EOH
    #{File.join(node[:concrete5][:install_path], 'cli', 'install-concrete5.php')} \\
    --config=#{File.join(node[:concrete5][:install_path], 'config.php')}
  EOH
end

