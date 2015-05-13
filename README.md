# Description

Installs/Configures optoro_memcached

# Requirements

## Platform:

* Ubuntu (= 14.04)

## Cookbooks:

* memcached (~> 1.7.2)
* optoro_monit
* logrotate
* optoro_metrics

# Attributes

* `node['optoro_memcached']['log_dir']` -  Defaults to `/var/log/memcached`.
* `node['optoro_memcached']['log_path']` -  Defaults to `#{node['optoro_memcached']['log_dir']}/memcached.log`.
* `node['optoro_memcached']['mem_size_mb']` -  Defaults to `512`.
* `node['monit']['address']` -  Defaults to `localhost`.

# Recipes

* optoro_memcached::default - Installs memcached
* optoro_memcahced::logrotate - Installs logrotate config for memcached
* optoro_memcahced::monit - Installs monit for memcached service

# License and Maintainer

Maintainer:: Alex Freidah (<afreidah@optoro.com>)

License:: MIT
