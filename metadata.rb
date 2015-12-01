name 'optoro_memcached'
maintainer 'DevOps'
maintainer_email 'devops@optoro.com'
license 'MIT'
description 'Installs/Configures optoro_memcached'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.2.1'

supports 'ubuntu', '= 14.04'

provides 'optoro_memcached::default'
provides 'optoro_memcached::logrotate'
provides 'optoro_memcached::monit'

recipe 'optoro_memcached::default', 'Installs memcached'
recipe 'optoro_memcached::logrotate', 'Installs logrotate config for memcached'
recipe 'optoro_memcached::monit', 'Installs monit for memcached service'

depends 'memcached', '~> 1.7.2'
depends 'optoro_monit'
depends 'logrotate'
