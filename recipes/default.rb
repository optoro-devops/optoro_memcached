#
# Cookbook Name:: optoro_memcached
# Recipe:: default
#
# Copyright (C) 2014 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'memcached::default'
include_recipe 'optoro_memcached::logrotate'
include_recipe 'optoro_memcached::memcached_exporter'
include_recipe 'optoro_memcached::consul'
