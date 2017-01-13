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
      #
      # == Options
      #
      # * +:upload_id+ - Object multipart upload ID
      #
      def abort_multipart_upload(object_key, options = {})
        options.deep_stringify_keys!
        request = abort_multipart_upload_request object_key, options
        request.send
      end

      def abort_multipart_upload_request(object_key, options = {})
        options.deep_stringify_keys!
        properties[:'object-key'] = object_key
        input = {
          config:           config,
          properties:       properties,
          api_name:         'Abort Multipart Upload',
          request_method:   'DELETE',
          request_uri:      '/<bucket-name>/<object-key>',
          request_params:   {
            'upload_id' => options['upload_id'],
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
      #
      # == Options
      #
      # * +:etag+ - MD5sum of the object part
      # * +:x_qs_encryption_customer_algorithm+ - Encryption algorithm of the object
      # * +:x_qs_encryption_customer_key+ - Encryption key of the object
      # * +:x_qs_encryption_customer_key_md5+ - MD5sum of encryption key
      # * +:upload_id+ - Object multipart upload ID
      # * +:object_parts+ - Object parts
      #
      def complete_multipart_upload(object_key, options = {})
        options.deep_stringify_keys!
        request = complete_multipart_upload_request object_key, options
        request.send
      end

      def complete_multipart_upload_request(object_key, options = {})
        options.deep_stringify_keys!
        properties[:'object-key'] = object_key
        input = {
          config:           config,
          properties:       properties,
          api_name:         'Complete multipart upload',
          request_method:   'POST',
          request_uri:      '/<bucket-name>/<object-key>',
          request_params:   {
            'upload_id' => options['upload_id'],
          },
          request_headers:  {
            'ETag'                               => options['etag'],
            'X-QS-Encryption-Customer-Algorithm' => options['x_qs_encryption_customer_algorithm'],
            'X-QS-Encryption-Customer-Key'       => options['x_qs_encryption_customer_key'],
            'X-QS-Encryption-Customer-Key-MD5'   => options['x_qs_encryption_customer_key_md5'],
          },
          request_elements: {
            'object_parts' => options['object_parts'],
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
      #
      # == Options
      #
      #
      def delete_object(object_key, options = {})
        options.deep_stringify_keys!
        request = delete_object_request object_key, options
        request.send
      end

      def delete_object_request(object_key, options = {})
        options.deep_stringify_keys!
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
      #
      # == Options
      #
      # * +:if_match+ - Check whether the ETag matches
      # * +:if_modified_since+ - Check whether the object has been modified
      # * +:if_none_match+ - Check whether the ETag does not match
      # * +:if_unmodified_since+ - Check whether the object has not been modified
      # * +:range+ - Specified range of the object
      # * +:x_qs_encryption_customer_algorithm+ - Encryption algorithm of the object
      # * +:x_qs_encryption_customer_key+ - Encryption key of the object
      # * +:x_qs_encryption_customer_key_md5+ - MD5sum of encryption key
      # * +:response_cache_control+ - Specified the Cache-Control response header
      # * +:response_content_disposition+ - Specified the Content-Disposition response header
      # * +:response_content_encoding+ - Specified the Content-Encoding response header
      # * +:response_content_language+ - Specified the Content-Language response header
      # * +:response_content_type+ - Specified the Content-Type response header
      # * +:response_expires+ - Specified the Expires response header
      #
      def get_object(object_key, options = {})
        options.deep_stringify_keys!
        request = get_object_request object_key, options
        request.send
      end

      def get_object_request(object_key, options = {})
        options.deep_stringify_keys!
        properties[:'object-key'] = object_key
        input = {
          config:           config,
          properties:       properties,
          api_name:         'GET Object',
          request_method:   'GET',
          request_uri:      '/<bucket-name>/<object-key>',
          request_params:   {
            'response-cache-control'       => options['response_cache_control'],
            'response-content-disposition' => options['response_content_disposition'],
            'response-content-encoding'    => options['response_content_encoding'],
            'response-content-language'    => options['response_content_language'],
            'response-content-type'        => options['response_content_type'],
            'response-expires'             => options['response_expires'],
          },
          request_headers:  {
            'If-Match'                           => options['if_match'],
            'If-Modified-Since'                  => options['if_modified_since'],
            'If-None-Match'                      => options['if_none_match'],
            'If-Unmodified-Since'                => options['if_unmodified_since'],
            'Range'                              => options['range'],
            'X-QS-Encryption-Customer-Algorithm' => options['x_qs_encryption_customer_algorithm'],
            'X-QS-Encryption-Customer-Key'       => options['x_qs_encryption_customer_key'],
            'X-QS-Encryption-Customer-Key-MD5'   => options['x_qs_encryption_customer_key_md5'],
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
      #
      # == Options
      #
      # * +:if_match+ - Check whether the ETag matches
      # * +:if_modified_since+ - Check whether the object has been modified
      # * +:if_none_match+ - Check whether the ETag does not match
      # * +:if_unmodified_since+ - Check whether the object has not been modified
      # * +:x_qs_encryption_customer_algorithm+ - Encryption algorithm of the object
      # * +:x_qs_encryption_customer_key+ - Encryption key of the object
      # * +:x_qs_encryption_customer_key_md5+ - MD5sum of encryption key
      #
      def head_object(object_key, options = {})
        options.deep_stringify_keys!
        request = head_object_request object_key, options
        request.send
      end

      def head_object_request(object_key, options = {})
        options.deep_stringify_keys!
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
            'If-Match'                           => options['if_match'],
            'If-Modified-Since'                  => options['if_modified_since'],
            'If-None-Match'                      => options['if_none_match'],
            'If-Unmodified-Since'                => options['if_unmodified_since'],
            'X-QS-Encryption-Customer-Algorithm' => options['x_qs_encryption_customer_algorithm'],
            'X-QS-Encryption-Customer-Key'       => options['x_qs_encryption_customer_key'],
            'X-QS-Encryption-Customer-Key-MD5'   => options['x_qs_encryption_customer_key_md5'],
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
      #
      # == Options
      #
      # * +:content_type+ - Object content type
      # * +:x_qs_encryption_customer_algorithm+ - Encryption algorithm of the object
      # * +:x_qs_encryption_customer_key+ - Encryption key of the object
      # * +:x_qs_encryption_customer_key_md5+ - MD5sum of encryption key
      #
      def initiate_multipart_upload(object_key, options = {})
        options.deep_stringify_keys!
        request = initiate_multipart_upload_request object_key, options
        request.send
      end

      def initiate_multipart_upload_request(object_key, options = {})
        options.deep_stringify_keys!
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
            'Content-Type'                       => options['content_type'],
            'X-QS-Encryption-Customer-Algorithm' => options['x_qs_encryption_customer_algorithm'],
            'X-QS-Encryption-Customer-Key'       => options['x_qs_encryption_customer_key'],
            'X-QS-Encryption-Customer-Key-MD5'   => options['x_qs_encryption_customer_key_md5'],
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
      #
      # == Options
      #
      # * +:limit+ - Limit results count
      # * +:part_number_marker+ - Object multipart upload part number
      # * +:upload_id+ - Object multipart upload ID
      #
      def list_multipart(object_key, options = {})
        options.deep_stringify_keys!
        request = list_multipart_request object_key, options
        request.send
      end

      def list_multipart_request(object_key, options = {})
        options.deep_stringify_keys!
        properties[:'object-key'] = object_key
        input = {
          config:           config,
          properties:       properties,
          api_name:         'List Multipart',
          request_method:   'GET',
          request_uri:      '/<bucket-name>/<object-key>',
          request_params:   {
            'limit'              => options['limit'],
            'part_number_marker' => options['part_number_marker'],
            'upload_id'          => options['upload_id'],
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
      #
      # == Options
      #
      # * +:access_control_request_headers+ - Request headers
      # * +:access_control_request_method+ - Request method
      # * +:origin+ - Request origin
      #
      def options_object(object_key, options = {})
        options.deep_stringify_keys!
        request = options_object_request object_key, options
        request.send
      end

      def options_object_request(object_key, options = {})
        options.deep_stringify_keys!
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
            'Access-Control-Request-Headers' => options['access_control_request_headers'],
            'Access-Control-Request-Method'  => options['access_control_request_method'],
            'Origin'                         => options['origin'],
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
      #
      # == Options
      #
      # * +:content_length+ - Object content size
      # * +:content_md5+ - Object MD5sum
      # * +:content_type+ - Object content type
      # * +:expect+ - Used to indicate that particular server behaviors are required by the client
      # * +:x_qs_copy_source+ - Copy source, format (/<bucket-name>/<object-key>)
      # * +:x_qs_copy_source_encryption_customer_algorithm+ - Encryption algorithm of the object
      # * +:x_qs_copy_source_encryption_customer_key+ - Encryption key of the object
      # * +:x_qs_copy_source_encryption_customer_key_md5+ - MD5sum of encryption key
      # * +:x_qs_copy_source_if_match+ - Check whether the copy source matches
      # * +:x_qs_copy_source_if_modified_since+ - Check whether the copy source has been modified
      # * +:x_qs_copy_source_if_none_match+ - Check whether the copy source does not match
      # * +:x_qs_copy_source_if_unmodified_since+ - Check whether the copy source has not been modified
      # * +:x_qs_encryption_customer_algorithm+ - Encryption algorithm of the object
      # * +:x_qs_encryption_customer_key+ - Encryption key of the object
      # * +:x_qs_encryption_customer_key_md5+ - MD5sum of encryption key
      # * +:x_qs_fetch_if_unmodified_since+ - Check whether fetch target object has not been modified
      # * +:x_qs_fetch_source+ - Fetch source, should be a valid url
      # * +:x_qs_move_source+ - Move source, format (/<bucket-name>/<object-key>)# * +:body+ - The request body
      #
      def put_object(object_key, options = {})
        options.deep_stringify_keys!
        request = put_object_request object_key, options
        request.send
      end

      def put_object_request(object_key, options = {})
        options.deep_stringify_keys!
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
            'Content-Length'                                 => options['content_length'],
            'Content-MD5'                                    => options['content_md5'],
            'Content-Type'                                   => options['content_type'],
            'Expect'                                         => options['expect'],
            'X-QS-Copy-Source'                               => options['x_qs_copy_source'],
            'X-QS-Copy-Source-Encryption-Customer-Algorithm' => options['x_qs_copy_source_encryption_customer_algorithm'],
            'X-QS-Copy-Source-Encryption-Customer-Key'       => options['x_qs_copy_source_encryption_customer_key'],
            'X-QS-Copy-Source-Encryption-Customer-Key-MD5'   => options['x_qs_copy_source_encryption_customer_key_md5'],
            'X-QS-Copy-Source-If-Match'                      => options['x_qs_copy_source_if_match'],
            'X-QS-Copy-Source-If-Modified-Since'             => options['x_qs_copy_source_if_modified_since'],
            'X-QS-Copy-Source-If-None-Match'                 => options['x_qs_copy_source_if_none_match'],
            'X-QS-Copy-Source-If-Unmodified-Since'           => options['x_qs_copy_source_if_unmodified_since'],
            'X-QS-Encryption-Customer-Algorithm'             => options['x_qs_encryption_customer_algorithm'],
            'X-QS-Encryption-Customer-Key'                   => options['x_qs_encryption_customer_key'],
            'X-QS-Encryption-Customer-Key-MD5'               => options['x_qs_encryption_customer_key_md5'],
            'X-QS-Fetch-If-Unmodified-Since'                 => options['x_qs_fetch_if_unmodified_since'],
            'X-QS-Fetch-Source'                              => options['x_qs_fetch_source'],
            'X-QS-Move-Source'                               => options['x_qs_move_source'],
          },
          request_elements: {
          },
          request_body:     options['body'],
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
      #
      # == Options
      #
      # * +:content_length+ - Object multipart content length
      # * +:content_md5+ - Object multipart content MD5sum
      # * +:x_qs_encryption_customer_algorithm+ - Encryption algorithm of the object
      # * +:x_qs_encryption_customer_key+ - Encryption key of the object
      # * +:x_qs_encryption_customer_key_md5+ - MD5sum of encryption key
      # * +:part_number+ - Object multipart upload part number
      # * +:upload_id+ - Object multipart upload ID# * +:body+ - The request body
      #
      def upload_multipart(object_key, options = {})
        options.deep_stringify_keys!
        request = upload_multipart_request object_key, options
        request.send
      end

      def upload_multipart_request(object_key, options = {})
        options.deep_stringify_keys!
        properties[:'object-key'] = object_key
        input = {
          config:           config,
          properties:       properties,
          api_name:         'Upload Multipart',
          request_method:   'PUT',
          request_uri:      '/<bucket-name>/<object-key>',
          request_params:   {
            'part_number' => options['part_number'],
            'upload_id'   => options['upload_id'],
          },
          request_headers:  {
            'Content-Length'                     => options['content_length'],
            'Content-MD5'                        => options['content_md5'],
            'X-QS-Encryption-Customer-Algorithm' => options['x_qs_encryption_customer_algorithm'],
            'X-QS-Encryption-Customer-Key'       => options['x_qs_encryption_customer_key'],
            'X-QS-Encryption-Customer-Key-MD5'   => options['x_qs_encryption_customer_key_md5'],
          },
          request_elements: {
          },
          request_body:     options['body'],
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
