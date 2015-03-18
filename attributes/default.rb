default['optoro_memcached']['log_dir'] = '/var/log/memcached'
default['optoro_memcached']['log_path'] = "#{node['optoro_memcached']['log_dir']}/memcached.log"
default['optoro_memcached']['mem_size_mb'] = '512'
default['monit']['address'] = 'localhost'
