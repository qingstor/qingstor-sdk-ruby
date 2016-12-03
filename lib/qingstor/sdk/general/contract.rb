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

module QingStor
  module SDK
    module Contract
      USER_SUPPORT_DIRECTORY    = "#{Dir.home}/.qingstor".freeze
      USER_CONFIG_FILENAME      = 'config.yaml'.freeze
      USER_CONFIG_FILEPATH      = "#{USER_SUPPORT_DIRECTORY}/#{USER_CONFIG_FILENAME}".freeze

      # GEM_DIRECTORY             = Gem::Specification.find_by_name('qingcloud-sdk').gem_dir
      # DEFAULT_SUPPORT_DIRECTORY = GEM_DIRECTORY + '/lib/qingcloud/sdk/commons/default'
      DEFAULT_SUPPORT_DIRECTORY = File.expand_path(File.dirname(__FILE__) + '/./default')
      DEFAULT_CONFIG_FILENAME   = 'config.yaml'.freeze
      DEFAULT_CONFIG_FILEPATH   = "#{DEFAULT_SUPPORT_DIRECTORY}/#{DEFAULT_CONFIG_FILENAME}".freeze
    end
  end
end
