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
          memcached::default
          optoro_memcached::monit
          optoro_memcached::logrotate
        ).each do |recipe|
          it 'includes #{recipe}' do
            expect(chef_run).to include_recipe(recipe)
          end
        end

        it 'creates the memcached confile' do
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
