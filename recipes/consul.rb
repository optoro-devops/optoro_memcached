include_recipe 'optoro_consul::client'

optoro_consul_service node['optoro_consul']['service_name'] do
  port 11_211
  params node['optoro_consul']['service']
end

consul_definition 'memcached-metrics' do
  type 'service'
  parameters(
    port: 9150,
    tags: [node['fqdn']],
    enable_tag_override: false,
    check: {
      interval: '10s',
      timeout: '5s',
      args: '["curl", "-s", "--fail", "http://localhost:9150/metrics", "&>", "/dev/null"]'
    }
  )
  notifies :reload, 'consul_service[consul]', :delayed
end
