name 'optoro_memcached'
maintainer 'DevOps'
maintainer_email 'devops@optoro.com'
license 'MIT'
description 'Installs/Configures optoro_memcached'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
source_url 'https://github.com/optoro-devops/optoro_memcached'
version '0.2.6'

supports 'ubuntu', '= 14.04'

provides 'optoro_memcached::default'
provides 'optoro_memcached::logrotate'

recipe 'optoro_memcached::default', 'Installs memcached'
recipe 'optoro_memcached::logrotate', 'Installs logrotate config for memcached'

depends 'memcached', '~> 1.7.2'
depends 'logrotate'
depends 'optoro_consul'
depends 'tar'
