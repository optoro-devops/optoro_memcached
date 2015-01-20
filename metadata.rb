name 'optoro_memcached'
maintainer 'Alex Freidah'
maintainer_email 'afreidah@optoro.com'
license 'All rights reserved'
description 'Installs/Configures optoro_memcached'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.1.4'

depends 'memcached', '~> 1.7.2'
depends 'newrelic', '~> 2.6.0'
depends 'optoro_monit', '~> 0.1.0'
depends 'logrotate', '~> 1.6.0'
depends 'apt', '~> 2.6.1'
