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

      def initialize(config, properties)
        self.config     = config
        self.properties = properties.deep_symbolize_keys
      end

      # delete_bucket: Delete a bucket.
      # Documentation URL: https://docs.qingcloud.com/qingstor/api/bucket/delete.html
      def delete
        request = delete_request
        request.send
      end

      def delete_request
        input = {
          config:           config,
          properties:       properties,
          api_name:         'DELETE Bucket',
          request_method:   'DELETE',
          request_uri:      '/<bucket-name>',
          request_params:   {
          },
          request_headers:  {
          },
          request_elements: {
          },
          request_body:     nil,
          status_code:      [
            204, # Bucket deleted
          ],
        }

        delete_bucket_input_validate input
        Request.new input
      end

      private

      def delete_bucket_input_validate(input)
        input.deep_stringify_keys!
      end

      public

      # delete_bucket_cors: Delete CORS information of the bucket.
      # Documentation URL: https://docs.qingcloud.com/qingstor/api/bucket/cors/delete_cors.html
      def delete_cors
        request = delete_cors_request
        request.send
      end

      def delete_cors_request
        input = {
          config:           config,
          properties:       properties,
          api_name:         'DELETE Bucket CORS',
          request_method:   'DELETE',
          request_uri:      '/<bucket-name>?cors',
          request_params:   {
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

        delete_bucket_cors_input_validate input
        Request.new input
      end

      private

      def delete_bucket_cors_input_validate(input)
        input.deep_stringify_keys!
      end

      public

      # delete_bucket_external_mirror: Delete external mirror of the bucket.
      # Documentation URL: https://docs.qingcloud.com/qingstor/api/bucket/external_mirror/delete_external_mirror.html
      def delete_external_mirror
        request = delete_external_mirror_request
        request.send
      end

      def delete_external_mirror_request
        input = {
          config:           config,
          properties:       properties,
          api_name:         'DELETE Bucket External Mirror',
          request_method:   'DELETE',
          request_uri:      '/<bucket-name>?mirror',
          request_params:   {
          },
          request_headers:  {
          },
          request_elements: {
          },
          request_body:     nil,
          status_code:      [
            204, # No content
          ],
        }

        delete_bucket_external_mirror_input_validate input
        Request.new input
      end

      private

      def delete_bucket_external_mirror_input_validate(input)
        input.deep_stringify_keys!
      end

      public

      # delete_bucket_policy: Delete policy information of the bucket.
      # Documentation URL: https://docs.qingcloud.com/qingstor/api/bucket/policy/delete_policy.html
      def delete_policy
        request = delete_policy_request
        request.send
      end

      def delete_policy_request
        input = {
          config:           config,
          properties:       properties,
          api_name:         'DELETE Bucket Policy',
          request_method:   'DELETE',
          request_uri:      '/<bucket-name>?policy',
          request_params:   {
          },
          request_headers:  {
          },
          request_elements: {
          },
          request_body:     nil,
          status_code:      [
            204, # No content
          ],
        }

        delete_bucket_policy_input_validate input
        Request.new input
      end

      private

      def delete_bucket_policy_input_validate(input)
        input.deep_stringify_keys!
      end

      public

      # delete_multiple_objects: Delete multiple objects from the bucket.
      # Documentation URL: https://docs.qingcloud.com/qingstor/api/bucket/delete_multiple.html
      def delete_multiple_objects(objects: [],
                                  quiet: nil)
        request = delete_multiple_objects_request objects: objects,
                                                  quiet:   quiet
        request.send
      end

      def delete_multiple_objects_request(objects: [],
                                          quiet: nil)
        input = {
          config:           config,
          properties:       properties,
          api_name:         'Delete Multiple Objects',
          request_method:   'POST',
          request_uri:      '/<bucket-name>?delete',
          request_params:   {
          },
          request_headers:  {
          },
          request_elements: {
            'objects' => objects,
            'quiet'   => quiet,
          },
          request_body:     nil,
          status_code:      [
            200, # OK
          ],
        }

        delete_multiple_objects_input_validate input
        Request.new input
      end

      private

      def delete_multiple_objects_input_validate(input)
        input.deep_stringify_keys!

        unless !input['request_elements']['objects'].nil? && !input['request_elements']['objects'].to_s.empty?
          raise ParameterRequiredError.new('objects', 'DeleteMultipleObjectsInput')
        end

        input['request_elements']['objects'].each do |x|
        end
      end

      public

      # get_bucket_acl: Get ACL information of the bucket.
      # Documentation URL: https://docs.qingcloud.com/qingstor/api/bucket/get_acl.html
      def get_acl
        request = get_acl_request
        request.send
      end

      def get_acl_request
        input = {
          config:           config,
          properties:       properties,
          api_name:         'GET Bucket ACL',
          request_method:   'GET',
          request_uri:      '/<bucket-name>?acl',
          request_params:   {
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

        get_bucket_acl_input_validate input
        Request.new input
      end

      private

      def get_bucket_acl_input_validate(input)
        input.deep_stringify_keys!
      end

      public

      # get_bucket_cors: Get CORS information of the bucket.
      # Documentation URL: https://docs.qingcloud.com/qingstor/api/bucket/cors/get_cors.html
      def get_cors
        request = get_cors_request
        request.send
      end

      def get_cors_request
        input = {
          config:           config,
          properties:       properties,
          api_name:         'GET Bucket CORS',
          request_method:   'GET',
          request_uri:      '/<bucket-name>?cors',
          request_params:   {
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

        get_bucket_cors_input_validate input
        Request.new input
      end

      private

      def get_bucket_cors_input_validate(input)
        input.deep_stringify_keys!
      end

      public

      # get_bucket_external_mirror: Get external mirror of the bucket.
      # Documentation URL: https://docs.qingcloud.com/qingstor/api/bucket/external_mirror/get_external_mirror.html
      def get_external_mirror
        request = get_external_mirror_request
        request.send
      end

      def get_external_mirror_request
        input = {
          config:           config,
          properties:       properties,
          api_name:         'GET Bucket External Mirror',
          request_method:   'GET',
          request_uri:      '/<bucket-name>?mirror',
          request_params:   {
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

        get_bucket_external_mirror_input_validate input
        Request.new input
      end

      private

      def get_bucket_external_mirror_input_validate(input)
        input.deep_stringify_keys!
      end

      public

      # get_bucket_policy: Get policy information of the bucket.
      # Documentation URL: https://https://docs.qingcloud.com/qingstor/api/bucket/policy/get_policy.html
      def get_policy
        request = get_policy_request
        request.send
      end

      def get_policy_request
        input = {
          config:           config,
          properties:       properties,
          api_name:         'GET Bucket Policy',
          request_method:   'GET',
          request_uri:      '/<bucket-name>?policy',
          request_params:   {
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

        get_bucket_policy_input_validate input
        Request.new input
      end

      private

      def get_bucket_policy_input_validate(input)
        input.deep_stringify_keys!
      end

      public

      # get_bucket_statistics: Get statistics information of the bucket.
      # Documentation URL: https://docs.qingcloud.com/qingstor/api/bucket/get_stats.html
      def get_statistics
        request = get_statistics_request
        request.send
      end

      def get_statistics_request
        input = {
          config:           config,
          properties:       properties,
          api_name:         'GET Bucket Statistics',
          request_method:   'GET',
          request_uri:      '/<bucket-name>?stats',
          request_params:   {
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

        get_bucket_statistics_input_validate input
        Request.new input
      end

      private

      def get_bucket_statistics_input_validate(input)
        input.deep_stringify_keys!
      end

      public

      # head_bucket: Check whether the bucket exists and available.
      # Documentation URL: https://docs.qingcloud.com/qingstor/api/bucket/head.html
      def head
        request = head_request
        request.send
      end

      def head_request
        input = {
          config:           config,
          properties:       properties,
          api_name:         'HEAD Bucket',
          request_method:   'HEAD',
          request_uri:      '/<bucket-name>',
          request_params:   {
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

        head_bucket_input_validate input
        Request.new input
      end

      private

      def head_bucket_input_validate(input)
        input.deep_stringify_keys!
      end

      public

      # list_multipart_uploads: List multipart uploads in the bucket.
      # Documentation URL: https://docs.qingcloud.com/qingstor/api/bucket/list_multipart_uploads.html
      def list_multipart_uploads(delimiter: '',
                                 limit: nil,
                                 marker: '',
                                 prefix: '')
        request = list_multipart_uploads_request delimiter: delimiter,
                                                 limit:     limit,
                                                 marker:    marker,
                                                 prefix:    prefix
        request.send
      end

      def list_multipart_uploads_request(delimiter: '',
                                         limit: nil,
                                         marker: '',
                                         prefix: '')
        input = {
          config:           config,
          properties:       properties,
          api_name:         'List Multipart Uploads',
          request_method:   'GET',
          request_uri:      '/<bucket-name>?uploads',
          request_params:   {
            'delimiter' => delimiter,
            'limit'     => limit,
            'marker'    => marker,
            'prefix'    => prefix,
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

        list_multipart_uploads_input_validate input
        Request.new input
      end

      private

      def list_multipart_uploads_input_validate(input)
        input.deep_stringify_keys!
      end

      public

      # list_objects: Retrieve the object list in a bucket.
      # Documentation URL: https://docs.qingcloud.com/qingstor/api/bucket/get.html
      def list_objects(delimiter: '',
                       limit: nil,
                       marker: '',
                       prefix: '')
        request = list_objects_request delimiter: delimiter,
                                       limit:     limit,
                                       marker:    marker,
                                       prefix:    prefix
        request.send
      end

      def list_objects_request(delimiter: '',
                               limit: nil,
                               marker: '',
                               prefix: '')
        input = {
          config:           config,
          properties:       properties,
          api_name:         'GET Bucket (List Objects)',
          request_method:   'GET',
          request_uri:      '/<bucket-name>',
          request_params:   {
            'delimiter' => delimiter,
            'limit'     => limit,
            'marker'    => marker,
            'prefix'    => prefix,
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

        list_objects_input_validate input
        Request.new input
      end

      private

      def list_objects_input_validate(input)
        input.deep_stringify_keys!
      end

      public

      # put_bucket: Create a new bucket.
      # Documentation URL: https://docs.qingcloud.com/qingstor/api/bucket/put.html
      def put
        request = put_request
        request.send
      end

      def put_request
        input = {
          config:           config,
          properties:       properties,
          api_name:         'PUT Bucket',
          request_method:   'PUT',
          request_uri:      '/<bucket-name>',
          request_params:   {
          },
          request_headers:  {
          },
          request_elements: {
          },
          request_body:     nil,
          status_code:      [
            201, # Bucket created
          ],
        }

        put_bucket_input_validate input
        Request.new input
      end

      private

      def put_bucket_input_validate(input)
        input.deep_stringify_keys!
      end

      public

      # put_bucket_acl: Set ACL information of the bucket.
      # Documentation URL: https://docs.qingcloud.com/qingstor/api/bucket/put_acl.html
      def put_acl(acl: [])
        request = put_acl_request acl: acl
        request.send
      end

      def put_acl_request(acl: [])
        input = {
          config:           config,
          properties:       properties,
          api_name:         'PUT Bucket ACL',
          request_method:   'PUT',
          request_uri:      '/<bucket-name>?acl',
          request_params:   {
          },
          request_headers:  {
          },
          request_elements: {
            'acl' => acl,
          },
          request_body:     nil,
          status_code:      [
            200, # OK
          ],
        }

        put_bucket_acl_input_validate input
        Request.new input
      end

      private

      def put_bucket_acl_input_validate(input)
        input.deep_stringify_keys!

        unless !input['request_elements']['acl'].nil? && !input['request_elements']['acl'].to_s.empty?
          raise ParameterRequiredError.new('acl', 'PutBucketACLInput')
        end

        input['request_elements']['acl'].each do |x|
          unless x['grantee'].nil?

            unless !x['grantee']['type'].nil? && !x['grantee']['type'].to_s.empty?
              raise ParameterRequiredError.new('type', 'grantee')
            end

            if x['grantee']['type'] && !x['grantee']['type'].to_s.empty?
              type_valid_values = %w(user group)
              unless type_valid_values.include? x['grantee']['type'].to_s
                raise ParameterValueNotAllowedError.new(
                  'type',
                  x['grantee']['type'],
                  type_valid_values,
                )
              end
            end

          end

          raise ParameterRequiredError.new('grantee', 'acl') if x['grantee'].nil?

          unless !x['permission'].nil? && !x['permission'].to_s.empty?
            raise ParameterRequiredError.new('permission', 'acl')
          end

          next unless x['permission'] && !x['permission'].to_s.empty?
          permission_valid_values = %w(READ WRITE FULL_CONTROL)
          next if permission_valid_values.include? x['permission'].to_s
          raise ParameterValueNotAllowedError.new(
            'permission',
            x['permission'],
            permission_valid_values,
          )
        end
      end

      public

      # put_bucket_cors: Set CORS information of the bucket.
      # Documentation URL: https://docs.qingcloud.com/qingstor/api/bucket/cors/put_cors.html
      def put_cors(cors_rules: [])
        request = put_cors_request cors_rules: cors_rules
        request.send
      end

      def put_cors_request(cors_rules: [])
        input = {
          config:           config,
          properties:       properties,
          api_name:         'PUT Bucket CORS',
          request_method:   'PUT',
          request_uri:      '/<bucket-name>?cors',
          request_params:   {
          },
          request_headers:  {
          },
          request_elements: {
            'cors_rules' => cors_rules,
          },
          request_body:     nil,
          status_code:      [
            200, # OK
          ],
        }

        put_bucket_cors_input_validate input
        Request.new input
      end

      private

      def put_bucket_cors_input_validate(input)
        input.deep_stringify_keys!

        unless !input['request_elements']['cors_rules'].nil? && !input['request_elements']['cors_rules'].to_s.empty?
          raise ParameterRequiredError.new('cors_rules', 'PutBucketCORSInput')
        end

        input['request_elements']['cors_rules'].each do |x|
          unless !x['allowed_methods'].nil? && !x['allowed_methods'].to_s.empty?
            raise ParameterRequiredError.new('allowed_methods', 'cors_rule')
          end

          unless !x['allowed_origin'].nil? && !x['allowed_origin'].to_s.empty?
            raise ParameterRequiredError.new('allowed_origin', 'cors_rule')
          end
        end
      end

      public

      # put_bucket_external_mirror: Set external mirror of the bucket.
      # Documentation URL: https://docs.qingcloud.com/qingstor/api/bucket/external_mirror/put_external_mirror.html
      def put_external_mirror(source_site: '')
        request = put_external_mirror_request source_site: source_site
        request.send
      end

      def put_external_mirror_request(source_site: '')
        input = {
          config:           config,
          properties:       properties,
          api_name:         'PUT Bucket External Mirror',
          request_method:   'PUT',
          request_uri:      '/<bucket-name>?mirror',
          request_params:   {
          },
          request_headers:  {
          },
          request_elements: {
            'source_site' => source_site,
          },
          request_body:     nil,
          status_code:      [
            200, # OK
          ],
        }

        put_bucket_external_mirror_input_validate input
        Request.new input
      end

      private

      def put_bucket_external_mirror_input_validate(input)
        input.deep_stringify_keys!

        unless !input['request_elements']['source_site'].nil? && !input['request_elements']['source_site'].to_s.empty?
          raise ParameterRequiredError.new('source_site', 'PutBucketExternalMirrorInput')
        end
      end

      public

      # put_bucket_policy: Set policy information of the bucket.
      # Documentation URL: https://docs.qingcloud.com/qingstor/api/bucket/policy/put_policy.html
      def put_policy(statement: [])
        request = put_policy_request statement: statement
        request.send
      end

      def put_policy_request(statement: [])
        input = {
          config:           config,
          properties:       properties,
          api_name:         'PUT Bucket Policy',
          request_method:   'PUT',
          request_uri:      '/<bucket-name>?policy',
          request_params:   {
          },
          request_headers:  {
          },
          request_elements: {
            'statement' => statement,
          },
          request_body:     nil,
          status_code:      [
            200, # OK
          ],
        }

        put_bucket_policy_input_validate input
        Request.new input
      end

      private

      def put_bucket_policy_input_validate(input)
        input.deep_stringify_keys!

        unless !input['request_elements']['statement'].nil? && !input['request_elements']['statement'].to_s.empty?
          raise ParameterRequiredError.new('statement', 'PutBucketPolicyInput')
        end

        input['request_elements']['statement'].each do |x|
          unless !x['action'].nil? && !x['action'].to_s.empty?
            raise ParameterRequiredError.new('action', 'statement')
          end

          unless x['condition'].nil?

            unless x['condition']['ip_address'].nil?

            end

            unless x['condition']['is_null'].nil?

            end

            unless x['condition']['not_ip_address'].nil?

            end

            unless x['condition']['string_like'].nil?

            end

            unless x['condition']['string_not_like'].nil?

            end

          end

          unless !x['effect'].nil? && !x['effect'].to_s.empty?
            raise ParameterRequiredError.new('effect', 'statement')
          end

          if x['effect'] && !x['effect'].to_s.empty?
            effect_valid_values = %w(allow deny)
            unless effect_valid_values.include? x['effect'].to_s
              raise ParameterValueNotAllowedError.new(
                'effect',
                x['effect'],
                effect_valid_values,
              )
            end
          end

          unless !x['id'].nil? && !x['id'].to_s.empty?
            raise ParameterRequiredError.new('id', 'statement')
          end

          unless !x['user'].nil? && !x['user'].to_s.empty?
            raise ParameterRequiredError.new('user', 'statement')
          end
        end
      end

      public
    end
  end
end
