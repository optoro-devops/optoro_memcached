require 'spec_helper'

describe 'optoro_memcached::default' do
  Resources::PLATFORMS.each do |platform, value|
    value['versions'].each do |version|
      context "On #{platform} #{version}" do
        include_context 'optoro_memcached'

        let(:chef_run) do
          ChefSpec::SoloRunner.new(platform: platform, version: version, log_level: :error) do |node|
            node.set['lsb']['codename'] = value['codename']
          end.converge(described_recipe)
        end

        it 'creates the monit config files' do
          expect(chef_run).to create_cookbook_file('/etc/monit/conf.d/memcached.conf')
        end

        it 'notifies the monit service to restart' do
          resource = chef_run.cookbook_file('/etc/monit/conf.d/memcached.conf')
          expect(resource).to notify('service[monit]').to(:restart).delayed
        end
      end
    end
  end
end
