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
