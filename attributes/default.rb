# encoding: utf-8
# vim: ft=ruby expandtab shiftwidth=2 tabstop=2

default[:concrete5][:git_repository] = 'https://github.com/concrete5/concrete5-5.7.0.git';
default[:concrete5][:git_revision]   = '5.7.3';
default[:concrete5][:locale]   = 'en_US';

default[:concrete5][:cli_dir]   = '/usr/share/concrete5';

default[:concrete5][:composer][:home]         = '/home/vagrant/.composer'
default[:concrete5][:composer][:install]    = 'curl -sS https://raw.githubusercontent.com/composer/getcomposer.org/master/web/installer | php'
default[:concrete5][:composer][:link]       = '/usr/local/bin/composer'

default[:concrete5][:db][:name] = "concrete5"
default[:concrete5][:db][:user] = "concrete5"
default[:concrete5][:db][:pass] = nil
default[:concrete5][:db][:host] = 'localhost'

default[:concrete5][:admin][:email]    = 'admin@example.com'
default[:concrete5][:admin][:password] = 'concrete5'

default[:concrete5][:starting_point] = 'elemental_blank' # elemental_blank or elemental_full
default[:concrete5][:site]           = 'Concrete5 Site'
default[:concrete5][:install_path]   = '/var/www/concrete5'
default[:concrete5][:reinstall]      = 'no'

default[:concrete5][:demo][:user_name] = 'demo'
default[:concrete5][:demo][:password]  = '12345'
default[:concrete5][:demo][:email]     = 'demo@example.com'
