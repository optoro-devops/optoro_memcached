include_recipe 'logrotate'

logrotate_app 'memcached' do
  path "/var/log/#{node['memcached']['logfilename']}"
  rotate '12'
  frequency 'weekly'
  options ['missingok', 'compress', 'notifempty', 'copytruncate']
  postrotate '/bin/kill -HUP `cat /var/run/memcached.pid 2> /dev/null` 2> /dev/null || true'
end
