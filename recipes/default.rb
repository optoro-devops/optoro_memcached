#
# Cookbook Name:: optoro_memcached
# Recipe:: default
#
# Copyright (C) 2014 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'memcached::default'

directory '/var/optoro' do
  mode 00755
  owner 'root'
  group 'root'
end

template '/etc/memcached.conf' do
  mode 00644
  owner 'root'
  group 'root'
  notifies :restart, 'service[memcached]', :delayed
end

directory node['optoro_memcached']['log_dir'] do
  owner 'root'
  group 'root'
end

include_recipe 'optoro_memcached::monit'
include_recipe 'optoro_memcached::logrotate'
include_recipe 'optoro_metrics::memcached'
