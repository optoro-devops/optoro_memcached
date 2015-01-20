cookbook_file '/etc/monit/conf.d/memcached.conf' do
  action :create
  notifies :restart, 'service[monit]', :delayed
end
