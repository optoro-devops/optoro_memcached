require 'spec_helper'

describe 'optoro_memcached::default' do
  Resources::PLATFORMS.each do |platform, value|
    value['versions'].each do |version|
      context 'On #{platform} #{version}' do
        include_context 'optoro_memcached'

        let(:chef_run) do
          ChefSpec::SoloRunner.new(platform: platform, version: version, log_level: :error) do |node|
            node.set['lsb']['codename'] = value['codename']
          end.converge(described_recipe)
        end

        %w(
          apt
          memcached::default
          optoro_memcached::monit
          optoro_memcached::logrotate
        ).each do |recipe|
          it 'includes #{recipe}' do
            expect(chef_run).to include_recipe(recipe)
          end
        end

        it 'installs the openjdk-7-jre-headless package' do
          expect(chef_run).to install_package('openjdk-7-jre-headless')
        end

        it 'creates the newrelic tar file' do
          expect(chef_run).to create_cookbook_file('/var/optoro/newrelic-npi.tar.gz').with(
            user: 'root',
            group: 'root',
            mode: 0644
          )
        end

        it 'notifies the the command to extract the tarfile' do
          resource = chef_run.cookbook_file('/var/optoro/newrelic-npi.tar.gz')
          expect(resource).to notify('execute[extract-newrelic-npi]').to(:run).immediately
        end

        it 'creates the newrelic plugin json template' do
          expect(chef_run).to create_template('/var/optoro/newrelic-npi/plugins/com.newrelic.plugins.memcached/newrelic_memcached_plugin-2.0.1/config/plugin.json').with(
            user: 'root',
            group: 'root',
            mode: 0644
          )
        end

        it 'creates newrelic init script' do
          expect(chef_run).to create_cookbook_file('/etc/init.d/newrelic_plugin_com.newrelic.plugins.memcached').with(
            user: 'root',
            group: 'root',
            mode: 0755
          )
        end

        it 'notifies the newrelic service when the init script is created' do
          resource = chef_run.cookbook_file('/etc/init.d/newrelic_plugin_com.newrelic.plugins.memcached')
          expect(resource).to notify('service[newrelic_plugin_com.newrelic.plugins.memcached]').to(:restart).delayed
        end

        it 'enables the newrelic service' do
          expect(chef_run).to enable_service('newrelic_plugin_com.newrelic.plugins.memcached')
        end

        it 'starts the newrelic service' do
          expect(chef_run).to start_service('newrelic_plugin_com.newrelic.plugins.memcached')
        end

        it 'creates the memcached.conffile' do
          expect(chef_run).to create_template('/etc/memcached.conf').with(
            user: 'root',
            group: 'root',
            mode: 0644
          )
        end

        it 'notifies the memcached service when the conf file is created' do
          resource = chef_run.template('/etc/memcached.conf')
          expect(resource).to notify('service[memcached]').to(:restart).delayed
        end

        it 'creates the log directory for memcached' do
          expect(chef_run).to create_directory('/var/log/memcached').with(
            owner: 'root',
            group: 'root'
          )
        end

        it 'creates the /var/optoro directory' do
          expect(chef_run).to create_directory('/var/optoro').with(
            user: 'root',
            group: 'root',
            mode: 0755
          )
        end
      end
    end
  end
end
