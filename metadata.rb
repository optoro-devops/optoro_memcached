name 'optoro_memcached'
maintainer 'Alex Freidah'
maintainer_email 'afreidah@optoro.com'
license 'MIT'
description 'Installs/Configures optoro_memcached'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.1.8'

depends 'memcached', '~> 1.7.2'
depends 'optoro_monit'
depends 'logrotate', '~> 1.8.0'
