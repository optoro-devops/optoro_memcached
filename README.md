# Description

Installs/Configures optoro_memcached

# Requirements

## Platform:

* ubuntu (= 14.04)

## Cookbooks:

* memcached (~> 1.7.2)
* logrotate

# Attributes

* `node['memcached']['memory']` -  Defaults to `512`.
* `node['memcached']['user']` -  Defaults to `nobody`.
* `node['memcached']['group']` -  Defaults to `nogroup`.

# Recipes

* optoro_memcached::default - Installs memcached
* optoro_memcached::logrotate - Installs logrotate config for memcached

# License and Maintainer

Maintainer:: DevOps (<devops@optoro.com>)

License:: MIT
