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

* `node['memcached']['memory']` -  Defaults to `512`.
* `node['memcached']['user']` -  Defaults to `nobody`.
* `node['memcached']['group']` -  Defaults to `nogroup`.
* `node['monit']['address']` -  Defaults to `localhost`.

# Recipes

* optoro_memcached::default - Installs memcached
* optoro_memcahced::logrotate - Installs logrotate config for memcached
* optoro_memcahced::monit - Installs monit for memcached service

# License and Maintainer

Maintainer:: DevOps (<devops@optoro.com>)

License:: MIT
