name             'concrete5'
maintainer       'Takayuki Miyauchi'
maintainer_email 'miyauchi@digitalcube.jp'
license          'Apache 2.0'
description      'Installs/Configures concrete5'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

recipe "concrete5", "Installs and configures Concrete5 LAMP stack on a single system"
recipe "concrete5::mysql", "Setup MySQL for the Concrete5"
recipe "concrete5::apache2", "Setup Apache + PHP for the Concrete5"

supports "centos"
supports "redhat"
supports "ubuntu"

depends 'apt'
depends 'apache2'
depends 'mysql'
depends 'php'
depends 'swap'

