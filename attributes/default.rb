# encoding: utf-8
# vim: ft=ruby expandtab shiftwidth=2 tabstop=2

default[:concrete5][:git_repository] = 'https://github.com/concrete5/concrete5.git';
default[:concrete5][:git_revision]   = '5.6.2.1';

default[:concrete5][:cli_url]   = 'https://raw2.github.com/concrete5/concrete5/master/cli/install-concrete5.php';
default[:concrete5][:cli_dir]   = '/usr/share/concrete5';

default[:concrete5][:db][:name] = "concrete5"
default[:concrete5][:db][:user] = "concrete5"
default[:concrete5][:db][:pass] = nil
default[:concrete5][:db][:host] = 'localhost'


default[:concrete5][:admin][:email]    = 'admin@example.com'
default[:concrete5][:admin][:password] = 'concrete5'

default[:concrete5][:starting_point] = 'blank'
default[:concrete5][:site]           = 'Concrete5 Site'
default[:concrete5][:install_path]   = '/var/www/concrete5'
default[:concrete5][:reinstall]      = 'no'

default[:concrete5][:demo][:user_name] = 'demo'
default[:concrete5][:demo][:password]  = '12345'
default[:concrete5][:demo][:email]     = 'demo@example.com'

