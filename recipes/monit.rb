require_recipe 'optoro_monit::default'

cookbook_file "/etc/monit/conf.d/memcached.conf" do
  action :create
  notifies :restart, 'service[monit]', :delayed
end
