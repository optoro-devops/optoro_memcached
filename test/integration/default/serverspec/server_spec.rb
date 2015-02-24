require 'serverspec'

set :backend, :exec

describe 'basic install' do
  describe package('memcached') do
    it { should be_installed }
  end

  describe package('openjdk-7-jre-headless') do
    it { should be_installed }
  end

  describe service('memcached') do
    it { should be_enabled }
    it { should be_running }
  end

  describe service('newrelic_plugin_com.newrelic.plugins.memcached') do
    it { should be_enabled }
    it { should be_running }
  end

  describe file('/var/optoro/newrelic-npi/plugins/com.newrelic.plugins.memcached/newrelic_memcached_plugin-2.0.1/config/plugin.json') do
    it { should be_file }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode '644' }
  end

  describe file('/var/optoro/newrelic-npi') do
    it { should be_directory }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode '755' }
  end
end

describe 'configuration' do
  describe file('/etc/init.d/newrelic_plugin_com.newrelic.plugins.memcached') do
    it { should be_file }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode '755' }
  end
end

# we cannot test that monit is running in a docker setup since it is an upstart job
describe 'monit recipe' do
  describe file('/etc/monit') do
    it { should be_directory }
  end

  describe file('/etc/monit/conf.d/memcached-monit.conf') do
    it { should be_file }
  end
end

describe 'logrotate recipe' do
  describe file('/etc/logrotate.conf') do
    it { should be_file }
  end

  describe file('/etc/logrotate.d') do
    it { should be_directory }
  end

  describe file('/etc/logrotate.d/memcached') do
    it { should be_file }
    it { should contain '/var/log/memcached/*.log' }
  end
end
