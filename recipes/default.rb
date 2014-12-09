#
# Cookbook Name:: optoro_memcached
# Recipe:: default
#
# Copyright (C) 2014 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'memcached::default'

package "openjdk-7-jre-headless"

directory '/var/optoro' do
  mode 00755
  owner 'root'
  group 'root'
end

cookbook_file '/var/optoro/newrelic-npi.tar.gz' do
  mode 00644
  owner 'root'
  group 'root'
end

execute 'extract newrelic npi' do
  command "tar -xvf /var/optoro/newrelic-npi.tar.gz -C /var/optoro"
end

template "/var/optoro/newrelic-npi/plugins/com.newrelic.plugins.memcached/newrelic_memcached_plugin-2.0.1/config/plugin.json" do
  mode 00644
  owner 'root'
  group 'root'
end

service 'newrelic_plugin_com.newrelic.plugins.memcached' do
  action [:enable, :start]
end

cookbook_file '/etc/init.d/newrelic_plugin_com.newrelic.plugins.memcached' do
  mode 00755
  owner 'root'
  group 'root'
  notifies :restart, 'service[newrelic_plugin_com.newrelic.plugins.memcached]', :delayed
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

