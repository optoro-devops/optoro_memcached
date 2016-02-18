require 'spec_helper'

describe 'optoro_memcached::default' do
  Resources::PLATFORMS.each do |platform, value|
    value['versions'].each do |version|
      context 'On #{platform} #{version}' do
        let(:chef_run) do
          ChefSpec::SoloRunner.new(platform: platform, version: version, log_level: :error) do |node|
            node.set['lsb']['codename'] = value['codename']
          end.converge(described_recipe)
        end

        %w(memcached::default
           optoro_memcached::logrotate).each do |recipe|
          it "includes #{recipe}" do
            expect(chef_run).to include_recipe(recipe)
          end
        end

        it 'creates the memcached configuration' do
          expect(chef_run).to create_template('/etc/memcached.conf').with(
            user: 'root',
            group: 'root',
            mode: '0644'
          )
        end
      end
    end
  end
end
