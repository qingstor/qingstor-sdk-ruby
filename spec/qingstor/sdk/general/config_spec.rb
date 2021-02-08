#  +-------------------------------------------------------------------------
#  | Copyright (C) 2016 Yunify, Inc.
#  +-------------------------------------------------------------------------
#  | Licensed under the Apache License, Version 2.0 (the "License");
#  | you may not use this work except in compliance with the License.
#  | You may obtain a copy of the License in the LICENSE file, or at:
#  |
#  | http://www.apache.org/licenses/LICENSE-2.0
#  |
#  | Unless required by applicable law or agreed to in writing, software
#  | distributed under the License is distributed on an "AS IS" BASIS,
#  | WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  | See the License for the specific language governing permissions and
#  | limitations under the License.
#  +-------------------------------------------------------------------------

require 'spec_helper'

module QingStor
  module SDK
    RSpec.describe Config do
      it 'has a convenient initializer' do
        config = Config.init 'ACCESS_KEY_ID', 'SECRET_ACCESS_KEY'

        expect(config[:access_key_id]).to eq 'ACCESS_KEY_ID'
        expect(config[:host]).to eq 'qingstor.com'
        expect(config[:log_level]).to eq 'warn'
      end

      it 'can init with a specified config' do
        config = Config.new(access_key_id:     'ACCESS_KEY_ID',
                            secret_access_key: 'SECRET_ACCESS_KEY',
                            host:              'qingstor.dev')
        expect(config[:access_key_id]).to eq 'ACCESS_KEY_ID'
        expect(config[:host]).to eq 'qingstor.dev'
      end

      it 'can be updated' do
        config = Config.new.load_default_config
        config.update(log_level: 'debug')
        expect(config[:log_level]).to eq 'debug'
      end

      it 'can load default config file' do
        config = Config.new.load_default_config
        expect(config[:access_key_id]).to be nil
        expect(config[:host]).to eq 'qingstor.com'
        expect(config[:log_level]).to eq 'warn'
      end

      it 'can not load user config file if no file path assigned' do
        begin
          Config.new.load_user_config
        rescue Errno::ENOENT
          expect(true).to be true
        end
      end

      it 'can load config from file' do
        config = Config.new.load_config_from_file File.expand_path('../default/config.yaml', __FILE__)
        expect(config[:access_key_id]).to be nil
        expect(config[:host]).to eq 'qingstor.com'
        expect(config[:log_level]).to eq 'warn'
      end

      it 'has a connection in config' do
        config = Config.new.load_default_config
        expect(config.connection).to_not be nil
      end

      it 'use env first' do
        config = Config.new
        expect(config[:access_key_id]).to eq nil
        expect(config[:secret_access_key]).to eq nil
        expect(config[:enable_virtual_host_style]).to eq false

        ENV[Contract::ENV_ACCESS_KEY_ID] = 'ak-env'
        ENV[Contract::ENV_SECRET_ACCESS_KEY] = 'sk-env'
        ENV[Contract::ENV_ENABLE_VIRTUAL_HOST_STYLE] = 'true'

        config_new = Config.new
        expect(config_new[:access_key_id]).to eq 'ak-env'
        expect(config_new[:secret_access_key]).to eq 'sk-env'
        expect(config_new[:enable_virtual_host_style]).to eq true
        # clean env after use
        ENV.delete(Contract::ENV_ACCESS_KEY_ID)
        ENV.delete(Contract::ENV_SECRET_ACCESS_KEY)
        ENV.delete(Contract::ENV_ENABLE_VIRTUAL_HOST_STYLE)
      end

      it 'cannot enable vhost with ip host' do
        config = Config.new
        begin
          config.update(enable_virtual_host_style: true,
                        host:                      '192.168.0.1')
        rescue ConfigurationError
          expect(true).to be true
        end
      end

      it 'cannot enable vhost with ip host in endpoint' do
        config = Config.new
        begin
          config.update(enable_virtual_host_style: true,
                        endpoint:                  '192.168.0.1:3000')
        rescue ConfigurationError
          expect(true).to be true
        end
      end

      it 'can enable vhost with host' do
        config = Config.new
        config.update(enable_virtual_host_style: true,
                      host:                      'qingstor.dev')
        expect(config[:enable_virtual_host_style]).to eq true
        expect(config[:host]).to eq 'qingstor.dev'
      end

      it 'can enable vhost with host in endpoint' do
        config = Config.new
        config.update(enable_virtual_host_style: true,
                      endpoint:                  'http://qingstor.dev')
        expect(config[:enable_virtual_host_style]).to eq true
        expect(config[:endpoint]).to eq 'http://qingstor.dev'
      end

      it 'can check itself' do
        config = Config.new
        begin
          config.check
        rescue ConfigurationError
          expect(true).to be true
        end

        config.update(access_key_id:         'ACCESS_KEY_ID',
                      secret_access_key:     'SECRET_ACCESS_KEY',
                      additional_user_agent: '中文')
        begin
          config.check
        rescue
          expect(true).to be true
        end

        config.update(additional_user_agent: 'text/integration')
        config.check
      end
    end
  end
end
