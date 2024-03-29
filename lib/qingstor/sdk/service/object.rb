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
      # Documentation URL: https://docsv4.qingcloud.com/user_guide/storage/object_storage/api/object/multipart/abort/
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
            'upload_id' => upload_id
          },
          request_headers:  {
          },
          request_elements: {
          },
          request_body:     nil,

          status_code:      [
            204
          ]
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

      # append_object: Append the Object.
      # Documentation URL: https://docsv4.qingcloud.com/user_guide/storage/object_storage/api/object/append/
      def append_object(object_key, position: nil, content_length: nil,
                        content_md5: '',
                        content_type: '',
                        x_qs_storage_class: '',
                        body: nil)
        request = append_object_request object_key, position: position, content_length: content_length,
          content_md5: content_md5,
          content_type: content_type,
          x_qs_storage_class: x_qs_storage_class,
          body: body
        request.send
      end

      def append_object_request(object_key, position: nil, content_length: nil,
                                content_md5: '',
                                content_type: '',
                                x_qs_storage_class: '',
                                body: nil)
        properties[:'object-key'] = object_key
        input = {
          config:           config,
          properties:       properties,
          api_name:         'Append Object',
          request_method:   'POST',
          request_uri:      '/<bucket-name>/<object-key>?append',
          request_params:   {
            'position' => position
          },
          request_headers:  {
            'Content-Length'     => content_length,
            'Content-MD5'        => content_md5,
            'Content-Type'       => content_type,
            'X-QS-Storage-Class' => x_qs_storage_class
          },
          request_elements: {
          },
          request_body:     body,

          status_code:      [
            200
          ]
        }

        append_object_input_validate input
        Request.new input
      end

      private

      def append_object_input_validate(input)
        input.deep_stringify_keys!

        unless !input['request_params']['position'].nil? && !input['request_params']['position'].to_s.empty?
          raise ParameterRequiredError.new('position', 'AppendObjectInput')
        end

        if input['request_headers']['X-QS-Storage-Class'] && !input['request_headers']['X-QS-Storage-Class'].to_s.empty?
          x_qs_storage_class_valid_values = %w[STANDARD STANDARD_IA]
          unless x_qs_storage_class_valid_values.include? input['request_headers']['X-QS-Storage-Class'].to_s
            raise ParameterValueNotAllowedError.new(
              'X-QS-Storage-Class',
              input['request_headers']['X-QS-Storage-Class'],
              x_qs_storage_class_valid_values,
            )
          end
        end
      end

      public

      # complete_multipart_upload: Complete multipart upload.
      # Documentation URL: https://docsv4.qingcloud.com/user_guide/storage/object_storage/api/object/multipart/complete/
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
            'upload_id' => upload_id
          },
          request_headers:  {
            'ETag'                               => etag,
            'X-QS-Encryption-Customer-Algorithm' => x_qs_encryption_customer_algorithm,
            'X-QS-Encryption-Customer-Key'       => x_qs_encryption_customer_key,
            'X-QS-Encryption-Customer-Key-MD5'   => x_qs_encryption_customer_key_md5
          },
          request_elements: {
            'object_parts' => object_parts
          },
          request_body:     nil,

          status_code:      [
            201
          ]
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

        unless !input['request_elements']['object_parts'].nil? && !input['request_elements']['object_parts'].empty?
          raise ParameterRequiredError.new('object_parts', 'CompleteMultipartUploadInput')
        end

        input['request_elements']['object_parts'].each do |x|
          unless !x['part_number'].nil? && !x['part_number'].to_s.empty?
            raise ParameterRequiredError.new('part_number', 'object_part')
          end
        end
      end

      public

      # delete_object: Delete the object.
      # Documentation URL: https://docsv4.qingcloud.com/user_guide/storage/object_storage/api/object/basic_opt/delete/
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
            204
          ]
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
      # Documentation URL: https://docsv4.qingcloud.com/user_guide/storage/object_storage/api/object/basic_opt/get/
      def get_object(object_key, response_cache_control: '',
                     response_content_disposition: '',
                     response_content_encoding: '',
                     response_content_language: '',
                     response_content_type: '',
                     response_expires: '', if_match: '',
                     if_modified_since: '',
                     if_none_match: '',
                     if_unmodified_since: '',
                     range: '',
                     x_qs_encryption_customer_algorithm: '',
                     x_qs_encryption_customer_key: '',
                     x_qs_encryption_customer_key_md5: '')
        request = get_object_request object_key, response_cache_control: response_cache_control,
          response_content_disposition: response_content_disposition,
          response_content_encoding: response_content_encoding,
          response_content_language: response_content_language,
          response_content_type: response_content_type,
          response_expires: response_expires, if_match: if_match,
          if_modified_since: if_modified_since,
          if_none_match: if_none_match,
          if_unmodified_since: if_unmodified_since,
          range: range,
          x_qs_encryption_customer_algorithm: x_qs_encryption_customer_algorithm,
          x_qs_encryption_customer_key: x_qs_encryption_customer_key,
          x_qs_encryption_customer_key_md5: x_qs_encryption_customer_key_md5
        request.send
      end

      def get_object_request(object_key, response_cache_control: '',
                             response_content_disposition: '',
                             response_content_encoding: '',
                             response_content_language: '',
                             response_content_type: '',
                             response_expires: '', if_match: '',
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
            'response-cache-control'       => response_cache_control,
            'response-content-disposition' => response_content_disposition,
            'response-content-encoding'    => response_content_encoding,
            'response-content-language'    => response_content_language,
            'response-content-type'        => response_content_type,
            'response-expires'             => response_expires
          },
          request_headers:  {
            'If-Match'                           => if_match,
            'If-Modified-Since'                  => if_modified_since,
            'If-None-Match'                      => if_none_match,
            'If-Unmodified-Since'                => if_unmodified_since,
            'Range'                              => range,
            'X-QS-Encryption-Customer-Algorithm' => x_qs_encryption_customer_algorithm,
            'X-QS-Encryption-Customer-Key'       => x_qs_encryption_customer_key,
            'X-QS-Encryption-Customer-Key-MD5'   => x_qs_encryption_customer_key_md5
          },
          request_elements: {
          },
          request_body:     nil,

          status_code:      [
            200,
            206,
            304,
            412
          ]
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
      # Documentation URL: https://docsv4.qingcloud.com/user_guide/storage/object_storage/api/object/basic_opt/head/
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
            'X-QS-Encryption-Customer-Key-MD5'   => x_qs_encryption_customer_key_md5
          },
          request_elements: {
          },
          request_body:     nil,

          status_code:      [
            200
          ]
        }

        head_object_input_validate input
        Request.new input
      end

      private

      def head_object_input_validate(input)
        input.deep_stringify_keys!
      end

      public

      # image_process: Image process with the action on the object
      # Documentation URL: https://docsv4.qingcloud.com/user_guide/storage/object_storage/api/object/image_process/
      def image_process(object_key, action: '',
                        response_cache_control: '',
                        response_content_disposition: '',
                        response_content_encoding: '',
                        response_content_language: '',
                        response_content_type: '',
                        response_expires: '', if_modified_since: '')
        request = image_process_request object_key, action: action,
          response_cache_control: response_cache_control,
          response_content_disposition: response_content_disposition,
          response_content_encoding: response_content_encoding,
          response_content_language: response_content_language,
          response_content_type: response_content_type,
          response_expires: response_expires, if_modified_since: if_modified_since
        request.send
      end

      def image_process_request(object_key, action: '',
                                response_cache_control: '',
                                response_content_disposition: '',
                                response_content_encoding: '',
                                response_content_language: '',
                                response_content_type: '',
                                response_expires: '', if_modified_since: '')
        properties[:'object-key'] = object_key
        input = {
          config:           config,
          properties:       properties,
          api_name:         'Image Process',
          request_method:   'GET',
          request_uri:      '/<bucket-name>/<object-key>?image',
          request_params:   {
            'action'                       => action,
            'response-cache-control'       => response_cache_control,
            'response-content-disposition' => response_content_disposition,
            'response-content-encoding'    => response_content_encoding,
            'response-content-language'    => response_content_language,
            'response-content-type'        => response_content_type,
            'response-expires'             => response_expires
          },
          request_headers:  {
            'If-Modified-Since' => if_modified_since
          },
          request_elements: {
          },
          request_body:     nil,

          status_code:      [
            200,
            304
          ]
        }

        image_process_input_validate input
        Request.new input
      end

      private

      def image_process_input_validate(input)
        input.deep_stringify_keys!

        unless !input['request_params']['action'].nil? && !input['request_params']['action'].to_s.empty?
          raise ParameterRequiredError.new('action', 'ImageProcessInput')
        end
      end

      public

      # initiate_multipart_upload: Initial multipart upload on the object.
      # Documentation URL: https://docsv4.qingcloud.com/user_guide/storage/object_storage/api/object/multipart/initiate/
      def initiate_multipart_upload(object_key, content_type: '',
                                    x_qs_encryption_customer_algorithm: '',
                                    x_qs_encryption_customer_key: '',
                                    x_qs_encryption_customer_key_md5: '',
                                    x_qs_meta_data: {},
                                    x_qs_storage_class: '')
        request = initiate_multipart_upload_request object_key, content_type:                       content_type,
                                                                x_qs_encryption_customer_algorithm: x_qs_encryption_customer_algorithm,
                                                                x_qs_encryption_customer_key:       x_qs_encryption_customer_key,
                                                                x_qs_encryption_customer_key_md5:   x_qs_encryption_customer_key_md5,
                                                                x_qs_meta_data:                     x_qs_meta_data,
                                                                x_qs_storage_class:                 x_qs_storage_class
        request.send
      end

      def initiate_multipart_upload_request(object_key, content_type: '',
                                            x_qs_encryption_customer_algorithm: '',
                                            x_qs_encryption_customer_key: '',
                                            x_qs_encryption_customer_key_md5: '',
                                            x_qs_meta_data: {},
                                            x_qs_storage_class: '')
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
            'X-QS-MetaData'                      => x_qs_meta_data,
            'X-QS-Storage-Class'                 => x_qs_storage_class
          },
          request_elements: {
          },
          request_body:     nil,

          status_code:      [
            200
          ]
        }

        initiate_multipart_upload_input_validate input
        Request.new input
      end

      private

      def initiate_multipart_upload_input_validate(input)
        input.deep_stringify_keys!

        if input['request_headers']['X-QS-Storage-Class'] && !input['request_headers']['X-QS-Storage-Class'].to_s.empty?
          x_qs_storage_class_valid_values = %w[STANDARD STANDARD_IA]
          unless x_qs_storage_class_valid_values.include? input['request_headers']['X-QS-Storage-Class'].to_s
            raise ParameterValueNotAllowedError.new(
              'X-QS-Storage-Class',
              input['request_headers']['X-QS-Storage-Class'],
              x_qs_storage_class_valid_values,
            )
          end
        end
      end

      public

      # list_multipart: List object parts.
      # Documentation URL: https://docsv4.qingcloud.com/user_guide/storage/object_storage/api/object/multipart/list/
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
            'upload_id'          => upload_id
          },
          request_headers:  {
          },
          request_elements: {
          },
          request_body:     nil,

          status_code:      [
            200
          ]
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
      # Documentation URL: https://docsv4.qingcloud.com/user_guide/storage/object_storage/api/object/basic_opt/options_object/
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
            'Origin'                         => origin
          },
          request_elements: {
          },
          request_body:     nil,

          status_code:      [
            200,
            304,
            412
          ]
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
      # Documentation URL: https://docsv4.qingcloud.com/user_guide/storage/object_storage/api/object/basic_opt/put/
      def put_object(object_key, cache_control: '',
                     content_encoding: '',
                     content_length: nil,
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
                     x_qs_meta_data: {},
                     x_qs_metadata_directive: '',
                     x_qs_move_source: '',
                     x_qs_storage_class: '',
                     body: nil)
        request = put_object_request object_key, cache_control:                                  cache_control,
                                                 content_encoding:                               content_encoding,
                                                 content_length:                                 content_length,
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
                                                 x_qs_meta_data:                                 x_qs_meta_data,
                                                 x_qs_metadata_directive:                        x_qs_metadata_directive,
                                                 x_qs_move_source:                               x_qs_move_source,
                                                 x_qs_storage_class:                             x_qs_storage_class,
                                                 body:                                           body
        request.send
      end

      def put_object_request(object_key, cache_control: '',
                             content_encoding: '',
                             content_length: nil,
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
                             x_qs_meta_data: {},
                             x_qs_metadata_directive: '',
                             x_qs_move_source: '',
                             x_qs_storage_class: '',
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
            'Cache-Control'                                  => cache_control,
            'Content-Encoding'                               => content_encoding,
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
            'X-QS-MetaData'                                  => x_qs_meta_data,
            'X-QS-Metadata-Directive'                        => x_qs_metadata_directive,
            'X-QS-Move-Source'                               => x_qs_move_source,
            'X-QS-Storage-Class'                             => x_qs_storage_class
          },
          request_elements: {
          },
          request_body:     body,

          status_code:      [
            201
          ]
        }

        put_object_input_validate input
        Request.new input
      end

      private

      def put_object_input_validate(input)
        input.deep_stringify_keys!

        if input['request_headers']['X-QS-Metadata-Directive'] && !input['request_headers']['X-QS-Metadata-Directive'].to_s.empty?
          x_qs_metadata_directive_valid_values = %w[COPY REPLACE]
          unless x_qs_metadata_directive_valid_values.include? input['request_headers']['X-QS-Metadata-Directive'].to_s
            raise ParameterValueNotAllowedError.new(
              'X-QS-Metadata-Directive',
              input['request_headers']['X-QS-Metadata-Directive'],
              x_qs_metadata_directive_valid_values,
            )
          end
        end

        if input['request_headers']['X-QS-Storage-Class'] && !input['request_headers']['X-QS-Storage-Class'].to_s.empty?
          x_qs_storage_class_valid_values = %w[STANDARD STANDARD_IA]
          unless x_qs_storage_class_valid_values.include? input['request_headers']['X-QS-Storage-Class'].to_s
            raise ParameterValueNotAllowedError.new(
              'X-QS-Storage-Class',
              input['request_headers']['X-QS-Storage-Class'],
              x_qs_storage_class_valid_values,
            )
          end
        end
      end

      public

      # upload_multipart: Upload object multipart.
      # Documentation URL: https://docsv4.qingcloud.com/user_guide/storage/object_storage/api/object/multipart/upload/
      def upload_multipart(object_key, part_number: nil,
                           upload_id: '', content_length: nil,
                           content_md5: '',
                           x_qs_copy_range: '',
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
                           body: nil)
        request = upload_multipart_request object_key, part_number: part_number,
          upload_id: upload_id, content_length: content_length,
          content_md5: content_md5,
          x_qs_copy_range: x_qs_copy_range,
          x_qs_copy_source: x_qs_copy_source,
          x_qs_copy_source_encryption_customer_algorithm: x_qs_copy_source_encryption_customer_algorithm,
          x_qs_copy_source_encryption_customer_key: x_qs_copy_source_encryption_customer_key,
          x_qs_copy_source_encryption_customer_key_md5: x_qs_copy_source_encryption_customer_key_md5,
          x_qs_copy_source_if_match: x_qs_copy_source_if_match,
          x_qs_copy_source_if_modified_since: x_qs_copy_source_if_modified_since,
          x_qs_copy_source_if_none_match: x_qs_copy_source_if_none_match,
          x_qs_copy_source_if_unmodified_since: x_qs_copy_source_if_unmodified_since,
          x_qs_encryption_customer_algorithm: x_qs_encryption_customer_algorithm,
          x_qs_encryption_customer_key: x_qs_encryption_customer_key,
          x_qs_encryption_customer_key_md5: x_qs_encryption_customer_key_md5,
          body: body
        request.send
      end

      def upload_multipart_request(object_key, part_number: nil,
                                   upload_id: '', content_length: nil,
                                   content_md5: '',
                                   x_qs_copy_range: '',
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
            'upload_id'   => upload_id
          },
          request_headers:  {
            'Content-Length'                                 => content_length,
            'Content-MD5'                                    => content_md5,
            'X-QS-Copy-Range'                                => x_qs_copy_range,
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
            'X-QS-Encryption-Customer-Key-MD5'               => x_qs_encryption_customer_key_md5
          },
          request_elements: {
          },
          request_body:     body,

          status_code:      [
            201
          ]
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
