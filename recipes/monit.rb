include_recipe 'optoro_monit::default'

cookbook_file '/etc/monit/conf.d/memcached-monit.conf' do
  action :create
  notifies :restart, 'service[monit]', :delayed
end
