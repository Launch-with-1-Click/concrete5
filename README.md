Concrete5 Cookbook
==================

The Chef Concrete5 cookbook installs and configures with LAMP.

Requirements
------------

### Platform

* Ubuntu
* RHEL/CentOS

### Cookbooks

* apache2
* mysql
* php

Attributes
----------
TODO: List you cookbook attributes here.

#### concrete5::default

* `node[:concrete5][:git_repository]`
    * Git repository of Concrete5 core.
    * Default: `https://github.com/concrete5/concrete5-5.7.0.git`
* `node[:concrete5][:git_revision]`
    * Concrete5 core git revisoion or release or branch.
    * Default: `5.7.3`
* `node[:concrete5][:locale]`
    * Concrete5 locale.
    * Default: `en_US`
* `node[:concrete5][:translations_repo_dir]`
    * Concrete5 translation file source.
    * Default: `https://raw.githubusercontent.com/concrete5/concrete5-translations/master/core-dev-57/`
* `node[:concrete5][:cli_dir]`
    * Install path of install-concrete5.php.
    * Default: `/usr/share/concrete5`    
* `node[:concrete5][:composer][:install]`
    * composer install commands.
    * Default: `curl -sS https://getcomposer.org/installer | php`
* `node[:concrete5][:composer][:link]`
    * composer install path.
    * Default: `/usr/local/bin/composer`
* `node[:concrete5][:db][:name]`
    * Concrete5 database name.
    * Default: `concrete5`
* `node[:concrete5][:db][:user]`
    * Concrete5 database user.
    * Default: `concrete5`
* `node[:concrete5][:db][:pass]`
    * Concrete5 database password.
    * Default: `nil`
* `node[:concrete5][:db][:host]`
    * Location of database server.
    * Default: `localhost`
* `node[:concrete5][:admin][:email]`
    * Email of the admin user of the install.
    * Default: `admin@example.com`
* `node[:concrete5][:admin][:password]`
    * Password of the admin user of the install.
    * Default: `concrete5`
* `node[:concrete5][:starting_point]`
    * Starting point to use.
    * Default: `elemental_blank`
* `node[:concrete5][:site]`
    * Name of the site.
    * Default: `Concrete5 Site`
* `node[:concrete5][:install_path]`
    * Target path of the install.
    * Default: `no`
* `node[:concrete5][:reinstall]`
    * If already installed at the target location, delete current install and reinstall.
    * Default: `no`
* `node[:concrete5][:demo][:user_name]`
    * Additional user username.
    * Default: `demo`
* `node[:concrete5][:demo][:password]`
    * Additional user password.
    * Default: `12345`
* `node[:concrete5][:demo][:email]`
    * Additional user email.
    * Default: `demo@example.com`


Usage
-----
#### concrete5::default

Just include `concrete5` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[concrete5]"
  ]
}
```

Contributing
------------

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

## Running tests

```
$ bundle install
$ bundle exec kitchen test
```

License
-------------------

Copyright:: 2010-2013, Chef Software, Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

Contributors
------------

* @Launch-with-1-Click
* [@miya0001](https://github.com/miya0001)
* [@sawanoboly](https://github.com/sawanoboly)
