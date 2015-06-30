name 'optoro_memcached'
maintainer 'DevOps'
maintainer_email 'devops@optoro.com'
license 'MIT'
description 'Installs/Configures optoro_memcached'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.2.0'

supports 'ubuntu', '= 14.04'

provides 'optoro_memcahced::default'
provides 'optoro_memcahced::logrotate'
provides 'optoro_memcahced::monit'

recipe 'optoro_memcached::default', 'Installs memcached'
recipe 'optoro_memcahced::logrotate', 'Installs logrotate config for memcached'
recipe 'optoro_memcahced::monit', 'Installs monit for memcached service'

depends 'memcached', '~> 1.7.2'
depends 'optoro_monit'
depends 'logrotate'
depends 'optoro_metrics'
