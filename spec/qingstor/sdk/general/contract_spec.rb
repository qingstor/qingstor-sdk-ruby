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
    RSpec.describe Contract do
      it 'should know user config file path' do
        expect(Contract::USER_CONFIG_FILEPATH).to eq "#{Dir.home}/.qingstor/config.yaml"
      end

      it 'should know default config file path' do
        expect(Contract::DEFAULT_CONFIG_FILEPATH.end_with?('default/config.yaml')).to be true
      end

      it 'should make sure default config file exists' do
        expect(File.exist?(Contract::DEFAULT_CONFIG_FILEPATH)).to be true
      end
    end
  end
end
