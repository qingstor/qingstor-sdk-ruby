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
    RSpec.describe Preprocessor do
      it 'processes qingstor request' do
        config = Config.new.load_default_config.update(host: 'qingstor.dev')
        # Logger.set_level 'debug'
        input = {
          config:           config,
          properties:       {
            'bucket-name' => 'test',
            'object-key'  => 'path/to/key.txt',
            'zone'        => 'beta'
          },
          api_name:         'GET Object',
          service_name:     'QingStor',
          request_method:   'POST',
          request_uri:      '/<bucket-name>/<object-key>',
          request_headers:  {
            'If-Match'          => '',
            'If-Modified-Since' => 'Thu, 01 Sep 2016 07:30:00 GMT',
            'Range'             => '100-'
          },
          request_elements: {},
          status_code:      [
            201
          ],
          request_body:     'This is body.'
        }

        result = Preprocessor.preprocess input

        time_check = 'Thu, 01 Sep 2016 07:30:00 GMT'
        expect(result[:request_endpoint]).to eq 'https://beta.qingstor.dev:443'
        expect(result[:request_headers][:'If-Modified-Since']).to eq time_check
        expect(result[:request_headers][:Range]).to eq '100-'
        expect(result[:request_uri]).to eq '/test/path/to/key.txt'
      end
    end
  end
end
