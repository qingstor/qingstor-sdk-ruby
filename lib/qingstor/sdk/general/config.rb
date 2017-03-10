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
require 'yaml'

require 'active_support/core_ext/hash/keys'
require 'active_support/core_ext/hash/deep_merge'
require 'net/http/persistent'

module QingStor
  module SDK
    class Config < Hash
      attr_accessor :connection

      def self.init(access_key_id, secret_access_key)
        initial_config = {
          access_key_id:     access_key_id,
          secret_access_key: secret_access_key,
        }
        Config.new(initial_config)
      end

      def initialize(initial_config = {})
        self.connection = Net::HTTP::Persistent.new
        load_default_config
        update initial_config
      end

      def update(another_config = {})
        deep_merge! another_config.deep_symbolize_keys!
        Logger.set_level self[:log_level]
        self
      end

      def check
        [:access_key_id, :secret_access_key, :host, :port, :protocol].each do |x|
          if !self[x] || self[x].to_s.empty?
            raise ConfigurationError, "#{x.to_sym} not specified"
          end
        end
        if self[:additional_user_agent] && !self[:additional_user_agent].empty?
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
        install_default_user_config unless File.exist? Contract::USER_CONFIG_FILEPATH
        load_config_from_file Contract::USER_CONFIG_FILEPATH
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
    end
  end
end
