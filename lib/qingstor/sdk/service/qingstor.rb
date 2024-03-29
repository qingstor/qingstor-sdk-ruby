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

require 'resolv'

require 'active_support/core_ext/hash/keys'

module QingStor
  module SDK
    # QingStor provides QingStor Service API (API Version 2016-01-06)
    class Service
      attr_accessor :config, :properties

      def initialize(config)
        config.check
        self.config = config
      end

      # list_buckets: Retrieve the bucket list.
      # Documentation URL: https://docsv4.qingcloud.com/user_guide/storage/object_storage/api/service/get/
      def list_buckets(limit: nil,
                       offset: nil, location: '')
        request = list_buckets_request limit: limit,
          offset: offset, location: location
        request.send
      end

      def list_buckets_request(limit: nil,
                               offset: nil, location: '')
        input = {
          config:           config,
          api_name:         'Get Service',
          request_method:   'GET',
          request_uri:      '/',
          request_params:   {
            'limit'  => limit,
            'offset' => offset
          },
          request_headers:  {
            'Location' => location
          },
          request_elements: {
          },
          request_body:     nil,

          status_code:      [
            200
          ]
        }

        list_buckets_input_validate input
        Request.new input
      end

      private

      def list_buckets_input_validate(input)
        input.deep_stringify_keys!
      end

      public

      def bucket(bucket_name, zone)
        properties = {
          'bucket-name' => bucket_name,
          'zone'        => zone
        }
        Bucket.new(config, properties)
      end
    end
  end
end
