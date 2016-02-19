require 'spec_helper'

describe 'optoro_memcached::logrotate' do
  Resources::PLATFORMS.each do |platform, value|
    value['versions'].each do |version|
      context "On #{platform} #{version}" do
        let(:chef_run) do
          ChefSpec::SoloRunner.new(platform: platform, version: version, log_level: :error) do |node|
            node.set['lsb']['codename'] = value['codename']
          end.converge(described_recipe)
        end

        it 'includes the logrotate::default recipe' do
          expect(chef_run).to include_recipe('logrotate::default')
        end

        it 'creates logrotate configuration for memcached' do
          expect(chef_run).to render_file('/etc/logrotate.d/memcached')
        end
      end
    end
  end
end
