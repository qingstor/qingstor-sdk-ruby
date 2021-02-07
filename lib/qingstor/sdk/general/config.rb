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

require 'fileutils'
require 'ipaddr'
require 'uri'
require 'yaml'

require 'active_support/core_ext/hash/keys'
require 'active_support/core_ext/hash/deep_merge'
require 'active_support/core_ext/object/blank'
require 'net/http/persistent'

module QingStor
  module SDK
    class Config < Hash
      attr_accessor :connection

      def self.init(access_key_id, secret_access_key)
        initial_config = {
          access_key_id:     access_key_id,
          secret_access_key: secret_access_key
        }
        Config.new(initial_config)
      end

      def initialize(initial_config = {})
        self.connection = Net::HTTP::Persistent.new
        # load default config as basic
        load_default_config
        # load from config, env path superior to ~/.qingstor/config.yaml
        load_user_config_path_exist
        # load envs, cover corresponding config if env exists
        load_env_config
        # cover by user's param
        update initial_config
      end

      def update(another_config = {})
        deep_merge! another_config.deep_symbolize_keys!
        parse_boolean(:enable_virtual_host_style)
        Logger.set_level self[:log_level]
        self
      end

      def check
        if self[:access_key_id].blank? && self[:secret_access_key].present? ||
           self[:access_key_id].present? && self[:secret_access_key].blank?
          raise ConfigurationError, 'ak and sk should be both both empty or not empty'
        end

        if self[:access_key_id].blank? && self[:secret_access_key].blank?
          Logger.warn 'Both ak and sk not configured, will call api as anonymous user'
        end

        # check endpoint and host/port/protocol
        if self[:endpoint].blank?
          # host/port/protocol must set if endpoint not set
          %i[host port protocol].each do |x|
            if self[x].blank?
              raise ConfigurationError, "#{x.to_sym} not specified"
            end
          end
        else
          # if endpoint set, host/port/protocol ignore, and warn
          %i[host port protocol].each do |x|
            if self[x].present?
              Logger.warn "Endpoint configured, #{x.to_sym} will be ignored"
            end
          end
        end

        # add ip check for vhost enabled
        if self[:enable_virtual_host_style]
          if self[:endpoint].present?
            uri = Preprocessor.parse_endpoint self[:endpoint]
            ip = uri.host
          else
            ip = self[:host]
          end
          if is_valid_ip? ip
            raise ConfigurationError, 'ip host not allowed if vhost enabled'
          end
        end

        if self[:additional_user_agent].present?
          self[:additional_user_agent].each_byte do |x|
            # Allow space(32) to ~(126) in ASCII Table, exclude "(34).
            if x < 32 || x > 126 || x == 32 || x == 34
              raise ConfigurationError, 'additional User-Agent contains characters that not allowed'
            end
          end
        end
        self
      end

      def load_default_config
        load_config_from_file Contract::DEFAULT_CONFIG_FILEPATH
      end

      def load_user_config
        if !ENV[Contract::ENV_CONFIG_PATH].nil?
          load_config_from_file ENV[Contract::ENV_CONFIG_PATH]
        else
          load_config_from_file Contract::USER_CONFIG_FILEPATH
        end
      end

      def load_env_config
        another_config = {}
        unless ENV[Contract::ENV_ACCESS_KEY_ID].nil?
          another_config[:access_key_id] =
            ENV[Contract::ENV_ACCESS_KEY_ID]
        end
        unless ENV[Contract::ENV_SECRET_ACCESS_KEY].nil?
          another_config[:secret_access_key] =
            ENV[Contract::ENV_SECRET_ACCESS_KEY]
        end
        unless ENV[Contract::ENV_ENABLE_VIRTUAL_HOST_STYLE].nil?
          another_config[:enable_virtual_host_style] =
            ENV[Contract::ENV_ENABLE_VIRTUAL_HOST_STYLE]
        end
        unless ENV[Contract::ENV_ENDPOINT].nil?
          another_config[:endpoint] =
              ENV[Contract::ENV_ENDPOINT]
        end
        update another_config
      end

      def load_config_from_file(path)
        path = path.sub '~', Dir.home if path.start_with? '~/'
        update YAML.load_file File.absolute_path path
      end

      private

      def install_default_user_config
        Logger.warn "Installing default config file to #{Contract::USER_CONFIG_FILEPATH}"
        FileUtils.mkdir_p Contract::USER_SUPPORT_DIRECTORY
        FileUtils.copy Contract::DEFAULT_CONFIG_FILEPATH, Contract::USER_CONFIG_FILEPATH
      end

      # load user config if path exist, and skip check
      def load_user_config_path_exist
        # if env path configured, update from env; otherwise, if ~/.qingstor/config.yaml exists, update from this
        if !ENV[Contract::ENV_CONFIG_PATH].nil? && File.exist?(ENV[Contract::ENV_CONFIG_PATH])
          load_config_from_file ENV[Contract::ENV_CONFIG_PATH]
        elsif File.exist? Contract::USER_CONFIG_FILEPATH
          load_config_from_file Contract::USER_CONFIG_FILEPATH
        end
      end

      def parse_boolean(key)
        self[key.to_sym] = self[key.to_sym].to_s.downcase == 'true'
      end

      def is_valid_ip?(ip)
        begin
          IPAddr.new ip
          return true
        rescue
          return false
        end
      end
    end
  end
end
