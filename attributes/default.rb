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

default[:php][:directives]['default_charset']            = 'UTF-8'
default[:php][:directives]['mbstring.language']          = 'neutral'
default[:php][:directives]['mbstring.internal_encoding'] = 'UTF-8'
default[:php][:directives]['date.timezone']              = 'UTC'

case node['platform_family']
when 'rhel', 'fedora'
  if node['platform_version'].to_f < 6
    default['php']['packages'] = %w{ php53 php53-devel php53-cli php-pear }
  else
    default['php']['packages'] = %w{ php php-devel php-cli php-pear php-mbstring }
  end
when 'debian'
  default['php']['packages']   = %w{ php5-cgi php5 php5-dev php5-cli php-pear }
else
  default['php']['packages']      = %w{ php5-cgi php5 php5-dev php5-cli php-pear }
end

