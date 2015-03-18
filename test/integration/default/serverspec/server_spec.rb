require 'serverspec'

set :backend, :exec

describe 'basic install' do
  describe package('memcached') do
    it { should be_installed }
  end

  describe service('memcached') do
    it { should be_enabled }
    it { should be_running }
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
