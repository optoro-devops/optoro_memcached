include_recipe 'optoro_consul::client'

tar_extract 'https://s3.amazonaws.com/latest-container-assets/memcached_exporter.tar.gz' do
  user 'root'
  group 'root'
  target_dir '/opt'
end

file '/opt/memcached_exporter' do
  owner 'root'
  group 'root'
  mode '0755'
end

cookbook_file '/etc/init/memcached_exporter.conf' do
  source 'memcached_exporter.init'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

service 'memcached_exporter' do
  action [:enable, :start]
  supports :restart => true
end

consul_definition 'instance-metrics' do
  type 'service'
  parameters(
    port: 9150,
    tags: [node['fqdn']],
    enableTagOverride: false,
    check: {
      interval: '10s',
      timeout: '5s',
      http: 'http://localhost:9150/metrics'
    }
  )
  notifies :reload, 'consul_service[consul]', :delayed
end
