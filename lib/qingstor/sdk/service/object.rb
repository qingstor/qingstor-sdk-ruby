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

require 'active_support/core_ext/hash/keys'

module QingStor
  module SDK
    class Bucket
      attr_accessor :config, :properties

      # abort_multipart_upload: Abort multipart upload.
      # Documentation URL: https://docs.qingcloud.com/qingstor/api/object/abort_multipart_upload.html
      def abort_multipart_upload(object_key, upload_id: '')
        request = abort_multipart_upload_request object_key, upload_id: upload_id
        request.send
      end

      def abort_multipart_upload_request(object_key, upload_id: '')
        properties[:'object-key'] = object_key
        input = {
          config:           config,
          properties:       properties,
          api_name:         'Abort Multipart Upload',
          request_method:   'DELETE',
          request_uri:      '/<bucket-name>/<object-key>',
          request_params:   {
            'upload_id' => upload_id,
          },
          request_headers:  {
          },
          request_elements: {
          },
          request_body:     nil,
          status_code:      [
            204, # Object multipart deleted
          ],
        }

        abort_multipart_upload_input_validate input
        Request.new input
      end

      private

      def abort_multipart_upload_input_validate(input)
        input.deep_stringify_keys!

        unless !input['request_params']['upload_id'].nil? && !input['request_params']['upload_id'].to_s.empty?
          raise ParameterRequiredError.new('upload_id', 'AbortMultipartUploadInput')
        end
      end

      public

      # complete_multipart_upload: Complete multipart upload.
      # Documentation URL: https://docs.qingcloud.com/qingstor/api/object/complete_multipart_upload.html
      def complete_multipart_upload(object_key, upload_id: '', etag: '',
                                    x_qs_encryption_customer_algorithm: '',
                                    x_qs_encryption_customer_key: '',
                                    x_qs_encryption_customer_key_md5: '', object_parts: [])
        request = complete_multipart_upload_request object_key, upload_id: upload_id, etag: etag,
          x_qs_encryption_customer_algorithm: x_qs_encryption_customer_algorithm,
          x_qs_encryption_customer_key: x_qs_encryption_customer_key,
          x_qs_encryption_customer_key_md5: x_qs_encryption_customer_key_md5, object_parts: object_parts
        request.send
      end

      def complete_multipart_upload_request(object_key, upload_id: '', etag: '',
                                            x_qs_encryption_customer_algorithm: '',
                                            x_qs_encryption_customer_key: '',
                                            x_qs_encryption_customer_key_md5: '', object_parts: [])
        properties[:'object-key'] = object_key
        input = {
          config:           config,
          properties:       properties,
          api_name:         'Complete multipart upload',
          request_method:   'POST',
          request_uri:      '/<bucket-name>/<object-key>',
          request_params:   {
            'upload_id' => upload_id,
          },
          request_headers:  {
            'ETag'                               => etag,
            'X-QS-Encryption-Customer-Algorithm' => x_qs_encryption_customer_algorithm,
            'X-QS-Encryption-Customer-Key'       => x_qs_encryption_customer_key,
            'X-QS-Encryption-Customer-Key-MD5'   => x_qs_encryption_customer_key_md5,
          },
          request_elements: {
            'object_parts' => object_parts,
          },
          request_body:     nil,
          status_code:      [
            201, # Object created
          ],
        }

        complete_multipart_upload_input_validate input
        Request.new input
      end

      private

      def complete_multipart_upload_input_validate(input)
        input.deep_stringify_keys!

        unless !input['request_params']['upload_id'].nil? && !input['request_params']['upload_id'].to_s.empty?
          raise ParameterRequiredError.new('upload_id', 'CompleteMultipartUploadInput')
        end

        input['request_elements']['object_parts'].each do |x|
          unless !x['part_number'].nil? && !x['part_number'].to_s.empty?
            raise ParameterRequiredError.new('part_number', 'object_part')
          end
        end
      end

      public

      # delete_object: Delete the object.
      # Documentation URL: https://docs.qingcloud.com/qingstor/api/object/delete.html
      def delete_object(object_key)
        request = delete_object_request object_key
        request.send
      end

      def delete_object_request(object_key)
        properties[:'object-key'] = object_key
        input = {
          config:           config,
          properties:       properties,
          api_name:         'DELETE Object',
          request_method:   'DELETE',
          request_uri:      '/<bucket-name>/<object-key>',
          request_params:   {
          },
          request_headers:  {
          },
          request_elements: {
          },
          request_body:     nil,
          status_code:      [
            204, # Object deleted
          ],
        }

        delete_object_input_validate input
        Request.new input
      end

      private

      def delete_object_input_validate(input)
        input.deep_stringify_keys!
      end

      public

      # get_object: Retrieve the object.
      # Documentation URL: https://docs.qingcloud.com/qingstor/api/object/get.html
      def get_object(object_key, if_match: '',
                     if_modified_since: '',
                     if_none_match: '',
                     if_unmodified_since: '',
                     range: '',
                     x_qs_encryption_customer_algorithm: '',
                     x_qs_encryption_customer_key: '',
                     x_qs_encryption_customer_key_md5: '')
        request = get_object_request object_key, if_match:                           if_match,
                                                 if_modified_since:                  if_modified_since,
                                                 if_none_match:                      if_none_match,
                                                 if_unmodified_since:                if_unmodified_since,
                                                 range:                              range,
                                                 x_qs_encryption_customer_algorithm: x_qs_encryption_customer_algorithm,
                                                 x_qs_encryption_customer_key:       x_qs_encryption_customer_key,
                                                 x_qs_encryption_customer_key_md5:   x_qs_encryption_customer_key_md5
        request.send
      end

      def get_object_request(object_key, if_match: '',
                             if_modified_since: '',
                             if_none_match: '',
                             if_unmodified_since: '',
                             range: '',
                             x_qs_encryption_customer_algorithm: '',
                             x_qs_encryption_customer_key: '',
                             x_qs_encryption_customer_key_md5: '')
        properties[:'object-key'] = object_key
        input = {
          config:           config,
          properties:       properties,
          api_name:         'GET Object',
          request_method:   'GET',
          request_uri:      '/<bucket-name>/<object-key>',
          request_params:   {
          },
          request_headers:  {
            'If-Match'                           => if_match,
            'If-Modified-Since'                  => if_modified_since,
            'If-None-Match'                      => if_none_match,
            'If-Unmodified-Since'                => if_unmodified_since,
            'Range'                              => range,
            'X-QS-Encryption-Customer-Algorithm' => x_qs_encryption_customer_algorithm,
            'X-QS-Encryption-Customer-Key'       => x_qs_encryption_customer_key,
            'X-QS-Encryption-Customer-Key-MD5'   => x_qs_encryption_customer_key_md5,
          },
          request_elements: {
          },
          request_body:     nil,
          status_code:      [
            200, # OK
            206,  # Partial content
            304,  # Not modified
            412,  # Precondition failed
          ],
        }

        get_object_input_validate input
        Request.new input
      end

      private

      def get_object_input_validate(input)
        input.deep_stringify_keys!
      end

      public

      # head_object: Check whether the object exists and available.
      # Documentation URL: https://docs.qingcloud.com/qingstor/api/object/head.html
      def head_object(object_key, if_match: '',
                      if_modified_since: '',
                      if_none_match: '',
                      if_unmodified_since: '',
                      x_qs_encryption_customer_algorithm: '',
                      x_qs_encryption_customer_key: '',
                      x_qs_encryption_customer_key_md5: '')
        request = head_object_request object_key, if_match:                           if_match,
                                                  if_modified_since:                  if_modified_since,
                                                  if_none_match:                      if_none_match,
                                                  if_unmodified_since:                if_unmodified_since,
                                                  x_qs_encryption_customer_algorithm: x_qs_encryption_customer_algorithm,
                                                  x_qs_encryption_customer_key:       x_qs_encryption_customer_key,
                                                  x_qs_encryption_customer_key_md5:   x_qs_encryption_customer_key_md5
        request.send
      end

      def head_object_request(object_key, if_match: '',
                              if_modified_since: '',
                              if_none_match: '',
                              if_unmodified_since: '',
                              x_qs_encryption_customer_algorithm: '',
                              x_qs_encryption_customer_key: '',
                              x_qs_encryption_customer_key_md5: '')
        properties[:'object-key'] = object_key
        input = {
          config:           config,
          properties:       properties,
          api_name:         'HEAD Object',
          request_method:   'HEAD',
          request_uri:      '/<bucket-name>/<object-key>',
          request_params:   {
          },
          request_headers:  {
            'If-Match'                           => if_match,
            'If-Modified-Since'                  => if_modified_since,
            'If-None-Match'                      => if_none_match,
            'If-Unmodified-Since'                => if_unmodified_since,
            'X-QS-Encryption-Customer-Algorithm' => x_qs_encryption_customer_algorithm,
            'X-QS-Encryption-Customer-Key'       => x_qs_encryption_customer_key,
            'X-QS-Encryption-Customer-Key-MD5'   => x_qs_encryption_customer_key_md5,
          },
          request_elements: {
          },
          request_body:     nil,
          status_code:      [
            200, # OK
          ],
        }

        head_object_input_validate input
        Request.new input
      end

      private

      def head_object_input_validate(input)
        input.deep_stringify_keys!
      end

      public

      # initiate_multipart_upload: Initial multipart upload on the object.
      # Documentation URL: https://docs.qingcloud.com/qingstor/api/object/initiate_multipart_upload.html
      def initiate_multipart_upload(object_key, content_type: '',
                                    x_qs_encryption_customer_algorithm: '',
                                    x_qs_encryption_customer_key: '',
                                    x_qs_encryption_customer_key_md5: '')
        request = initiate_multipart_upload_request object_key, content_type:                       content_type,
                                                                x_qs_encryption_customer_algorithm: x_qs_encryption_customer_algorithm,
                                                                x_qs_encryption_customer_key:       x_qs_encryption_customer_key,
                                                                x_qs_encryption_customer_key_md5:   x_qs_encryption_customer_key_md5
        request.send
      end

      def initiate_multipart_upload_request(object_key, content_type: '',
                                            x_qs_encryption_customer_algorithm: '',
                                            x_qs_encryption_customer_key: '',
                                            x_qs_encryption_customer_key_md5: '')
        properties[:'object-key'] = object_key
        input = {
          config:           config,
          properties:       properties,
          api_name:         'Initiate Multipart Upload',
          request_method:   'POST',
          request_uri:      '/<bucket-name>/<object-key>?uploads',
          request_params:   {
          },
          request_headers:  {
            'Content-Type'                       => content_type,
            'X-QS-Encryption-Customer-Algorithm' => x_qs_encryption_customer_algorithm,
            'X-QS-Encryption-Customer-Key'       => x_qs_encryption_customer_key,
            'X-QS-Encryption-Customer-Key-MD5'   => x_qs_encryption_customer_key_md5,
          },
          request_elements: {
          },
          request_body:     nil,
          status_code:      [
            200, # OK
          ],
        }

        initiate_multipart_upload_input_validate input
        Request.new input
      end

      private

      def initiate_multipart_upload_input_validate(input)
        input.deep_stringify_keys!
      end

      public

      # list_multipart: List object parts.
      # Documentation URL: https://docs.qingcloud.com/qingstor/api/object/list_multipart.html
      def list_multipart(object_key, limit: nil,
                         part_number_marker: nil,
                         upload_id: '')
        request = list_multipart_request object_key, limit:              limit,
                                                     part_number_marker: part_number_marker,
                                                     upload_id:          upload_id
        request.send
      end

      def list_multipart_request(object_key, limit: nil,
                                 part_number_marker: nil,
                                 upload_id: '')
        properties[:'object-key'] = object_key
        input = {
          config:           config,
          properties:       properties,
          api_name:         'List Multipart',
          request_method:   'GET',
          request_uri:      '/<bucket-name>/<object-key>',
          request_params:   {
            'limit'              => limit,
            'part_number_marker' => part_number_marker,
            'upload_id'          => upload_id,
          },
          request_headers:  {
          },
          request_elements: {
          },
          request_body:     nil,
          status_code:      [
            200, # OK
          ],
        }

        list_multipart_input_validate input
        Request.new input
      end

      private

      def list_multipart_input_validate(input)
        input.deep_stringify_keys!

        unless !input['request_params']['upload_id'].nil? && !input['request_params']['upload_id'].to_s.empty?
          raise ParameterRequiredError.new('upload_id', 'ListMultipartInput')
        end
      end

      public

      # options_object: Check whether the object accepts a origin with method and header.
      # Documentation URL: https://docs.qingcloud.com/qingstor/api/object/options.html
      def options_object(object_key, access_control_request_headers: '',
                         access_control_request_method: '',
                         origin: '')
        request = options_object_request object_key, access_control_request_headers: access_control_request_headers,
                                                     access_control_request_method:  access_control_request_method,
                                                     origin:                         origin
        request.send
      end

      def options_object_request(object_key, access_control_request_headers: '',
                                 access_control_request_method: '',
                                 origin: '')
        properties[:'object-key'] = object_key
        input = {
          config:           config,
          properties:       properties,
          api_name:         'OPTIONS Object',
          request_method:   'OPTIONS',
          request_uri:      '/<bucket-name>/<object-key>',
          request_params:   {
          },
          request_headers:  {
            'Access-Control-Request-Headers' => access_control_request_headers,
            'Access-Control-Request-Method'  => access_control_request_method,
            'Origin'                         => origin,
          },
          request_elements: {
          },
          request_body:     nil,
          status_code:      [
            200, # OK
          ],
        }

        options_object_input_validate input
        Request.new input
      end

      private

      def options_object_input_validate(input)
        input.deep_stringify_keys!

        unless !input['request_headers']['Access-Control-Request-Method'].nil? && !input['request_headers']['Access-Control-Request-Method'].to_s.empty?
          raise ParameterRequiredError.new('Access-Control-Request-Method', 'OptionsObjectInput')
        end

        unless !input['request_headers']['Origin'].nil? && !input['request_headers']['Origin'].to_s.empty?
          raise ParameterRequiredError.new('Origin', 'OptionsObjectInput')
        end
      end

      public

      # put_object: Upload the object.
      # Documentation URL: https://docs.qingcloud.com/qingstor/api/object/put.html
      def put_object(object_key, content_length: nil,
                     content_md5: '',
                     content_type: '',
                     expect: '',
                     x_qs_copy_source: '',
                     x_qs_copy_source_encryption_customer_algorithm: '',
                     x_qs_copy_source_encryption_customer_key: '',
                     x_qs_copy_source_encryption_customer_key_md5: '',
                     x_qs_copy_source_if_match: '',
                     x_qs_copy_source_if_modified_since: '',
                     x_qs_copy_source_if_none_match: '',
                     x_qs_copy_source_if_unmodified_since: '',
                     x_qs_encryption_customer_algorithm: '',
                     x_qs_encryption_customer_key: '',
                     x_qs_encryption_customer_key_md5: '',
                     x_qs_fetch_if_unmodified_since: '',
                     x_qs_fetch_source: '',
                     x_qs_move_source: '',
                     body: nil)
        request = put_object_request object_key, content_length:                                 content_length,
                                                 content_md5:                                    content_md5,
                                                 content_type:                                   content_type,
                                                 expect:                                         expect,
                                                 x_qs_copy_source:                               x_qs_copy_source,
                                                 x_qs_copy_source_encryption_customer_algorithm: x_qs_copy_source_encryption_customer_algorithm,
                                                 x_qs_copy_source_encryption_customer_key:       x_qs_copy_source_encryption_customer_key,
                                                 x_qs_copy_source_encryption_customer_key_md5:   x_qs_copy_source_encryption_customer_key_md5,
                                                 x_qs_copy_source_if_match:                      x_qs_copy_source_if_match,
                                                 x_qs_copy_source_if_modified_since:             x_qs_copy_source_if_modified_since,
                                                 x_qs_copy_source_if_none_match:                 x_qs_copy_source_if_none_match,
                                                 x_qs_copy_source_if_unmodified_since:           x_qs_copy_source_if_unmodified_since,
                                                 x_qs_encryption_customer_algorithm:             x_qs_encryption_customer_algorithm,
                                                 x_qs_encryption_customer_key:                   x_qs_encryption_customer_key,
                                                 x_qs_encryption_customer_key_md5:               x_qs_encryption_customer_key_md5,
                                                 x_qs_fetch_if_unmodified_since:                 x_qs_fetch_if_unmodified_since,
                                                 x_qs_fetch_source:                              x_qs_fetch_source,
                                                 x_qs_move_source:                               x_qs_move_source,
                                                 body:                                           body
        request.send
      end

      def put_object_request(object_key, content_length: nil,
                             content_md5: '',
                             content_type: '',
                             expect: '',
                             x_qs_copy_source: '',
                             x_qs_copy_source_encryption_customer_algorithm: '',
                             x_qs_copy_source_encryption_customer_key: '',
                             x_qs_copy_source_encryption_customer_key_md5: '',
                             x_qs_copy_source_if_match: '',
                             x_qs_copy_source_if_modified_since: '',
                             x_qs_copy_source_if_none_match: '',
                             x_qs_copy_source_if_unmodified_since: '',
                             x_qs_encryption_customer_algorithm: '',
                             x_qs_encryption_customer_key: '',
                             x_qs_encryption_customer_key_md5: '',
                             x_qs_fetch_if_unmodified_since: '',
                             x_qs_fetch_source: '',
                             x_qs_move_source: '',
                             body: nil)
        properties[:'object-key'] = object_key
        input = {
          config:           config,
          properties:       properties,
          api_name:         'PUT Object',
          request_method:   'PUT',
          request_uri:      '/<bucket-name>/<object-key>',
          request_params:   {
          },
          request_headers:  {
            'Content-Length'                                 => content_length,
            'Content-MD5'                                    => content_md5,
            'Content-Type'                                   => content_type,
            'Expect'                                         => expect,
            'X-QS-Copy-Source'                               => x_qs_copy_source,
            'X-QS-Copy-Source-Encryption-Customer-Algorithm' => x_qs_copy_source_encryption_customer_algorithm,
            'X-QS-Copy-Source-Encryption-Customer-Key'       => x_qs_copy_source_encryption_customer_key,
            'X-QS-Copy-Source-Encryption-Customer-Key-MD5'   => x_qs_copy_source_encryption_customer_key_md5,
            'X-QS-Copy-Source-If-Match'                      => x_qs_copy_source_if_match,
            'X-QS-Copy-Source-If-Modified-Since'             => x_qs_copy_source_if_modified_since,
            'X-QS-Copy-Source-If-None-Match'                 => x_qs_copy_source_if_none_match,
            'X-QS-Copy-Source-If-Unmodified-Since'           => x_qs_copy_source_if_unmodified_since,
            'X-QS-Encryption-Customer-Algorithm'             => x_qs_encryption_customer_algorithm,
            'X-QS-Encryption-Customer-Key'                   => x_qs_encryption_customer_key,
            'X-QS-Encryption-Customer-Key-MD5'               => x_qs_encryption_customer_key_md5,
            'X-QS-Fetch-If-Unmodified-Since'                 => x_qs_fetch_if_unmodified_since,
            'X-QS-Fetch-Source'                              => x_qs_fetch_source,
            'X-QS-Move-Source'                               => x_qs_move_source,
          },
          request_elements: {
          },
          request_body:     body,
          status_code:      [
            201, # Object created
          ],
        }

        put_object_input_validate input
        Request.new input
      end

      private

      def put_object_input_validate(input)
        input.deep_stringify_keys!
      end

      public

      # upload_multipart: Upload object multipart.
      # Documentation URL: https://docs.qingcloud.com/qingstor/api/object/multipart/upload_multipart.html
      def upload_multipart(object_key, part_number: nil,
                           upload_id: '', content_length: nil,
                           content_md5: '',
                           x_qs_encryption_customer_algorithm: '',
                           x_qs_encryption_customer_key: '',
                           x_qs_encryption_customer_key_md5: '',
                           body: nil)
        request = upload_multipart_request object_key, part_number: part_number,
          upload_id: upload_id, content_length: content_length,
          content_md5: content_md5,
          x_qs_encryption_customer_algorithm: x_qs_encryption_customer_algorithm,
          x_qs_encryption_customer_key: x_qs_encryption_customer_key,
          x_qs_encryption_customer_key_md5: x_qs_encryption_customer_key_md5,
          body: body
        request.send
      end

      def upload_multipart_request(object_key, part_number: nil,
                                   upload_id: '', content_length: nil,
                                   content_md5: '',
                                   x_qs_encryption_customer_algorithm: '',
                                   x_qs_encryption_customer_key: '',
                                   x_qs_encryption_customer_key_md5: '',
                                   body: nil)
        properties[:'object-key'] = object_key
        input = {
          config:           config,
          properties:       properties,
          api_name:         'Upload Multipart',
          request_method:   'PUT',
          request_uri:      '/<bucket-name>/<object-key>',
          request_params:   {
            'part_number' => part_number,
            'upload_id'   => upload_id,
          },
          request_headers:  {
            'Content-Length'                     => content_length,
            'Content-MD5'                        => content_md5,
            'X-QS-Encryption-Customer-Algorithm' => x_qs_encryption_customer_algorithm,
            'X-QS-Encryption-Customer-Key'       => x_qs_encryption_customer_key,
            'X-QS-Encryption-Customer-Key-MD5'   => x_qs_encryption_customer_key_md5,
          },
          request_elements: {
          },
          request_body:     body,
          status_code:      [
            201, # Object multipart created
          ],
        }

        upload_multipart_input_validate input
        Request.new input
      end

      private

      def upload_multipart_input_validate(input)
        input.deep_stringify_keys!

        unless !input['request_params']['part_number'].nil? && !input['request_params']['part_number'].to_s.empty?
          raise ParameterRequiredError.new('part_number', 'UploadMultipartInput')
        end

        unless !input['request_params']['upload_id'].nil? && !input['request_params']['upload_id'].to_s.empty?
          raise ParameterRequiredError.new('upload_id', 'UploadMultipartInput')
        end
      end

      public
    end
  end
end
