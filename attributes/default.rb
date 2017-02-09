default['memcached']['memory'] = '512'
default['memcached']['user'] = 'nobody'
default['memcached']['group'] = 'nogroup'

# Consul
default['optoro_consul']['register_consul_service'] = false
default['optoro_consul']['service_name'] = 'memcached'
