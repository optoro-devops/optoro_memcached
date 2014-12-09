include_recipe 'optoro_logrotate::default'

logrotate_app 'memcached' do
  path "#{node['optoro_memcached']['log_dir']}/*.log"
  rotate '12'
  frequency 'weekly'
  options ['missingok', 'compress', 'notifempty', 'copytruncate']
end
