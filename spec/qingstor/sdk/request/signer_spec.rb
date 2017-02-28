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
    RSpec.describe Signer do
      it 'signs qingstor request' do
        config = Config.init 'ENV_ACCESS_KEY_ID', 'ENV_SECRET_ACCESS_KEY'
        Logger.set_level 'debug'
        input = {
          config:          config,
          properties:      {},
          service_name:    'QingStor',
          request_method:  'GET',
          request_uri:     '/?acl',
          request_params:  {
            'upload_id'   => 'fde133b5f6d932cd9c79bac3c7318da1',
            'part_number' => '0',
          },
          request_headers: {
            'Date'        => 'Mon, 01 Jan 0001 00:00:00 GMT',
            'X-QS-Test-1' => 'Test 1',
            'X-QS-Test-2' => 'Test 2',
          },
        }
        input[:id] = 324_347

        input = Preprocessor.preprocess input
        input[:request_headers][:'Content-Type'] = ''
        result = Signer.sign input

        check  = 'QS ENV_ACCESS_KEY_ID:bvglZF9iMOv1RaCTxPYWxexmt1UN2m5WKngYnhDEp2c='
        expect(result[:request_headers][:Authorization]).to eq check
      end

      it 'signs qingstor request contains Chinese' do
        config = Config.init 'ENV_ACCESS_KEY_ID', 'ENV_SECRET_ACCESS_KEY'
        Logger.set_level 'debug'
        input = {
          config:          config,
          properties:      {
            'object-key' => '中文',
          },
          service_name:    'QingStor',
          request_method:  'GET',
          request_uri:     '/bucket-name/<object-key>',
          request_params:  {},
          request_headers: {
            'Date' => 'Mon, 01 Jan 0001 00:00:00 GMT',
          },
        }
        input[:id] = 324_347

        input = Preprocessor.preprocess input
        input[:request_headers][:'Content-Type'] = ''
        result = Signer.sign input

        check  = 'QS ENV_ACCESS_KEY_ID:XsTXX50kzqBf92zLG1aIUIJmZ0hqIHoaHgkumwnV3fs='
        expect(result[:request_headers][:Authorization]).to eq check
      end
    end

    RSpec.describe Signer do
      it 'signs qingstor request by query' do
        config = Config.init 'ENV_ACCESS_KEY_ID', 'ENV_SECRET_ACCESS_KEY'
        input = {
          config:          config,
          properties:      {},
          service_name:    'QingStor',
          request_method:  'GET',
          request_uri:     '/?acl',
          request_params:  {
            'upload_id'   => 'fde133b5f6d932cd9c79bac3c7318da1',
            'part_number' => '0',
          },
          request_headers: {
            'Date'        => 'Mon, 01 Jan 0001 00:00:00 GMT',
            'X-QS-Test-1' => 'Test 1',
            'X-QS-Test-2' => 'Test 2',
          },
        }
        input[:id] = 324_347

        input = Preprocessor.preprocess input
        input[:request_headers][:'Content-Type'] = ''
        result = Signer.sign_query input, -62_135_596_800

        check  = 'gTdB%2FcmD6rjv8CbFRDfFbHc64q442rYNAp99Hm7fBl4%3D'
        expect(result[:request_params][:signature]).to eq check
      end
    end
  end
end
