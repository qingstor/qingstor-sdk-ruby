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
        config.check
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
            204
          ]
        }

        delete_bucket_input_validate input
        Request.new input
      end

      private

      def delete_bucket_input_validate(input)
        input.deep_stringify_keys!
      end

      public

      # delete_bucket_cname: Delete bucket CNAME setting of the bucket.
      # Documentation URL: https://docs.qingcloud.com/qingstor/api/bucket/cname/delete_cname.html
      def delete_cname(domain: '')
        request = delete_cname_request domain: domain
        request.send
      end

      def delete_cname_request(domain: '')
        input = {
          config:           config,
          properties:       properties,
          api_name:         'DELETE Bucket CNAME',
          request_method:   'DELETE',
          request_uri:      '/<bucket-name>?cname',
          request_params:   {
          },
          request_headers:  {
          },
          request_elements: {
            'domain' => domain
          },
          request_body:     nil,

          status_code:      [
            204
          ]
        }

        delete_bucket_cname_input_validate input
        Request.new input
      end

      private

      def delete_bucket_cname_input_validate(input)
        input.deep_stringify_keys!

        unless !input['request_elements']['domain'].nil? && !input['request_elements']['domain'].to_s.empty?
          raise ParameterRequiredError.new('domain', 'DeleteBucketCNAMEInput')
        end
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
            204
          ]
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
            204
          ]
        }

        delete_bucket_external_mirror_input_validate input
        Request.new input
      end

      private

      def delete_bucket_external_mirror_input_validate(input)
        input.deep_stringify_keys!
      end

      public

      # delete_bucket_lifecycle: Delete Lifecycle information of the bucket.
      # Documentation URL: https://docs.qingcloud.com/qingstor/api/bucket/lifecycle/delete_lifecycle.html
      def delete_lifecycle
        request = delete_lifecycle_request
        request.send
      end

      def delete_lifecycle_request
        input = {
          config:           config,
          properties:       properties,
          api_name:         'DELETE Bucket Lifecycle',
          request_method:   'DELETE',
          request_uri:      '/<bucket-name>?lifecycle',
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

        delete_bucket_lifecycle_input_validate input
        Request.new input
      end

      private

      def delete_bucket_lifecycle_input_validate(input)
        input.deep_stringify_keys!
      end

      public

      # delete_bucket_logging: Delete bucket logging setting of the bucket.
      # Documentation URL: https://docs.qingcloud.com/qingstor/api/bucket/logging/delete_logging.html
      def delete_logging
        request = delete_logging_request
        request.send
      end

      def delete_logging_request
        input = {
          config:           config,
          properties:       properties,
          api_name:         'DELETE Bucket Logging',
          request_method:   'DELETE',
          request_uri:      '/<bucket-name>?logging',
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

        delete_bucket_logging_input_validate input
        Request.new input
      end

      private

      def delete_bucket_logging_input_validate(input)
        input.deep_stringify_keys!
      end

      public

      # delete_bucket_notification: Delete Notification information of the bucket.
      # Documentation URL: https://docs.qingcloud.com/qingstor/api/bucket/notification/delete_notification.html
      def delete_notification
        request = delete_notification_request
        request.send
      end

      def delete_notification_request
        input = {
          config:           config,
          properties:       properties,
          api_name:         'DELETE Bucket Notification',
          request_method:   'DELETE',
          request_uri:      '/<bucket-name>?notification',
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

        delete_bucket_notification_input_validate input
        Request.new input
      end

      private

      def delete_bucket_notification_input_validate(input)
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
            204
          ]
        }

        delete_bucket_policy_input_validate input
        Request.new input
      end

      private

      def delete_bucket_policy_input_validate(input)
        input.deep_stringify_keys!
      end

      public

      # delete_bucket_replication: Delete Replication information of the bucket.
      # Documentation URL: https://docs.qingcloud.com/qingstor/api/bucket/replication/delete_replication.html
      def delete_replication
        request = delete_replication_request
        request.send
      end

      def delete_replication_request
        input = {
          config:           config,
          properties:       properties,
          api_name:         'DELETE Bucket Replication',
          request_method:   'DELETE',
          request_uri:      '/<bucket-name>?replication',
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

        delete_bucket_replication_input_validate input
        Request.new input
      end

      private

      def delete_bucket_replication_input_validate(input)
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
            'quiet'   => quiet
          },
          request_body:     nil,

          status_code:      [
            200
          ]
        }

        delete_multiple_objects_input_validate input
        Request.new input
      end

      private

      def delete_multiple_objects_input_validate(input)
        input.deep_stringify_keys!

        unless !input['request_elements']['objects'].nil? && !input['request_elements']['objects'].empty?
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
            200
          ]
        }

        get_bucket_acl_input_validate input
        Request.new input
      end

      private

      def get_bucket_acl_input_validate(input)
        input.deep_stringify_keys!
      end

      public

      # get_bucket_cname: Get bucket CNAME setting of the bucket.
      # Documentation URL: https://docs.qingcloud.com/qingstor/api/bucket/cname/get_cname.html
      def get_cname(type: '')
        request = get_cname_request type: type
        request.send
      end

      def get_cname_request(type: '')
        input = {
          config:           config,
          properties:       properties,
          api_name:         'GET Bucket CNAME',
          request_method:   'GET',
          request_uri:      '/<bucket-name>?cname',
          request_params:   {
            'type' => type
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

        get_bucket_cname_input_validate input
        Request.new input
      end

      private

      def get_bucket_cname_input_validate(input)
        input.deep_stringify_keys!

        if input['request_params']['type'] && !input['request_params']['type'].to_s.empty?
          type_valid_values = %w[website normal]
          unless type_valid_values.include? input['request_params']['type'].to_s
            raise ParameterValueNotAllowedError.new(
              'type',
              input['request_params']['type'],
              type_valid_values,
            )
          end
        end
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
            200
          ]
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
            200
          ]
        }

        get_bucket_external_mirror_input_validate input
        Request.new input
      end

      private

      def get_bucket_external_mirror_input_validate(input)
        input.deep_stringify_keys!
      end

      public

      # get_bucket_lifecycle: Get Lifecycle information of the bucket.
      # Documentation URL: https://docs.qingcloud.com/qingstor/api/bucket/lifecycle/get_lifecycle.html
      def get_lifecycle
        request = get_lifecycle_request
        request.send
      end

      def get_lifecycle_request
        input = {
          config:           config,
          properties:       properties,
          api_name:         'GET Bucket Lifecycle',
          request_method:   'GET',
          request_uri:      '/<bucket-name>?lifecycle',
          request_params:   {
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

        get_bucket_lifecycle_input_validate input
        Request.new input
      end

      private

      def get_bucket_lifecycle_input_validate(input)
        input.deep_stringify_keys!
      end

      public

      # get_bucket_logging: Get bucket logging setting of the bucket.
      # Documentation URL: https://docs.qingcloud.com/qingstor/api/bucket/logging/get_logging.html
      def get_logging
        request = get_logging_request
        request.send
      end

      def get_logging_request
        input = {
          config:           config,
          properties:       properties,
          api_name:         'GET Bucket Logging',
          request_method:   'GET',
          request_uri:      '/<bucket-name>?logging',
          request_params:   {
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

        get_bucket_logging_input_validate input
        Request.new input
      end

      private

      def get_bucket_logging_input_validate(input)
        input.deep_stringify_keys!
      end

      public

      # get_bucket_notification: Get Notification information of the bucket.
      # Documentation URL: https://docs.qingcloud.com/qingstor/api/bucket/notification/get_notification.html
      def get_notification
        request = get_notification_request
        request.send
      end

      def get_notification_request
        input = {
          config:           config,
          properties:       properties,
          api_name:         'GET Bucket Notification',
          request_method:   'GET',
          request_uri:      '/<bucket-name>?notification',
          request_params:   {
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

        get_bucket_notification_input_validate input
        Request.new input
      end

      private

      def get_bucket_notification_input_validate(input)
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
            200
          ]
        }

        get_bucket_policy_input_validate input
        Request.new input
      end

      private

      def get_bucket_policy_input_validate(input)
        input.deep_stringify_keys!
      end

      public

      # get_bucket_replication: Get Replication information of the bucket.
      # Documentation URL: https://docs.qingcloud.com/qingstor/api/bucket/replication/get_replication.html
      def get_replication
        request = get_replication_request
        request.send
      end

      def get_replication_request
        input = {
          config:           config,
          properties:       properties,
          api_name:         'GET Bucket Replication',
          request_method:   'GET',
          request_uri:      '/<bucket-name>?replication',
          request_params:   {
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

        get_bucket_replication_input_validate input
        Request.new input
      end

      private

      def get_bucket_replication_input_validate(input)
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
            200
          ]
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
            200
          ]
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
                                 key_marker: '',
                                 limit: nil,
                                 prefix: '',
                                 upload_id_marker: '')
        request = list_multipart_uploads_request delimiter:        delimiter,
                                                 key_marker:       key_marker,
                                                 limit:            limit,
                                                 prefix:           prefix,
                                                 upload_id_marker: upload_id_marker
        request.send
      end

      def list_multipart_uploads_request(delimiter: '',
                                         key_marker: '',
                                         limit: nil,
                                         prefix: '',
                                         upload_id_marker: '')
        input = {
          config:           config,
          properties:       properties,
          api_name:         'List Multipart Uploads',
          request_method:   'GET',
          request_uri:      '/<bucket-name>?uploads',
          request_params:   {
            'delimiter'        => delimiter,
            'key_marker'       => key_marker,
            'limit'            => limit,
            'prefix'           => prefix,
            'upload_id_marker' => upload_id_marker
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
            'prefix'    => prefix
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
            201
          ]
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
            'acl' => acl
          },
          request_body:     nil,

          status_code:      [
            200
          ]
        }

        put_bucket_acl_input_validate input
        Request.new input
      end

      private

      def put_bucket_acl_input_validate(input)
        input.deep_stringify_keys!

        unless !input['request_elements']['acl'].nil? && !input['request_elements']['acl'].empty?
          raise ParameterRequiredError.new('acl', 'PutBucketACLInput')
        end

        input['request_elements']['acl'].each do |x|
          unless x['grantee'].nil?

            unless !x['grantee']['type'].nil? && !x['grantee']['type'].to_s.empty?
              raise ParameterRequiredError.new('type', 'grantee')
            end

            if x['grantee']['type'] && !x['grantee']['type'].to_s.empty?
              type_valid_values = %w[user group]
              unless type_valid_values.include? x['grantee']['type'].to_s
                raise ParameterValueNotAllowedError.new(
                  'type',
                  x['grantee']['type'],
                  type_valid_values,
                )
              end
            end

          end

          if x['grantee'].nil?
            raise ParameterRequiredError.new('grantee', 'acl')
          end

          unless !x['permission'].nil? && !x['permission'].to_s.empty?
            raise ParameterRequiredError.new('permission', 'acl')
          end

          next unless x['permission'] && !x['permission'].to_s.empty?

          permission_valid_values = %w[READ WRITE FULL_CONTROL]
          next if permission_valid_values.include? x['permission'].to_s

          raise ParameterValueNotAllowedError.new(
            'permission',
            x['permission'],
            permission_valid_values,
          )
        end
      end

      public

      # put_bucket_cname: Set bucket CNAME of the bucket.
      # Documentation URL: https://docs.qingcloud.com/qingstor/api/bucket/cname/put_cname.html
      def put_cname(domain: '',
                    type: '')
        request = put_cname_request domain: domain,
                                    type:   type
        request.send
      end

      def put_cname_request(domain: '',
                            type: '')
        input = {
          config:           config,
          properties:       properties,
          api_name:         'PUT Bucket CNAME',
          request_method:   'PUT',
          request_uri:      '/<bucket-name>?cname',
          request_params:   {
          },
          request_headers:  {
          },
          request_elements: {
            'domain' => domain,
            'type'   => type
          },
          request_body:     nil,

          status_code:      [
            200
          ]
        }

        put_bucket_cname_input_validate input
        Request.new input
      end

      private

      def put_bucket_cname_input_validate(input)
        input.deep_stringify_keys!

        unless !input['request_elements']['domain'].nil? && !input['request_elements']['domain'].to_s.empty?
          raise ParameterRequiredError.new('domain', 'PutBucketCNAMEInput')
        end

        if input['request_elements']['type'] && !input['request_elements']['type'].to_s.empty?
          type_valid_values = %w[normal website]
          unless type_valid_values.include? input['request_elements']['type'].to_s
            raise ParameterValueNotAllowedError.new(
              'type',
              input['request_elements']['type'],
              type_valid_values,
            )
          end
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
            'cors_rules' => cors_rules
          },
          request_body:     nil,

          status_code:      [
            200
          ]
        }

        put_bucket_cors_input_validate input
        Request.new input
      end

      private

      def put_bucket_cors_input_validate(input)
        input.deep_stringify_keys!

        unless !input['request_elements']['cors_rules'].nil? && !input['request_elements']['cors_rules'].empty?
          raise ParameterRequiredError.new('cors_rules', 'PutBucketCORSInput')
        end

        input['request_elements']['cors_rules'].each do |x|
          unless !x['allowed_methods'].nil? && !x['allowed_methods'].empty?
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
            'source_site' => source_site
          },
          request_body:     nil,

          status_code:      [
            200
          ]
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

      # put_bucket_lifecycle: Set Lifecycle information of the bucket.
      # Documentation URL: https://docs.qingcloud.com/qingstor/api/bucket/lifecycle/put_lifecycle.html
      def put_lifecycle(rule: [])
        request = put_lifecycle_request rule: rule
        request.send
      end

      def put_lifecycle_request(rule: [])
        input = {
          config:           config,
          properties:       properties,
          api_name:         'PUT Bucket Lifecycle',
          request_method:   'PUT',
          request_uri:      '/<bucket-name>?lifecycle',
          request_params:   {
          },
          request_headers:  {
          },
          request_elements: {
            'rule' => rule
          },
          request_body:     nil,

          status_code:      [
            200
          ]
        }

        put_bucket_lifecycle_input_validate input
        Request.new input
      end

      private

      def put_bucket_lifecycle_input_validate(input)
        input.deep_stringify_keys!

        unless !input['request_elements']['rule'].nil? && !input['request_elements']['rule'].empty?
          raise ParameterRequiredError.new('rule', 'PutBucketLifecycleInput')
        end

        input['request_elements']['rule'].each do |x|
          unless x['abort_incomplete_multipart_upload'].nil?

            unless !x['abort_incomplete_multipart_upload']['days_after_initiation'].nil? && !x['abort_incomplete_multipart_upload']['days_after_initiation'].to_s.empty?
              raise ParameterRequiredError.new('days_after_initiation', 'abort_incomplete_multipart_upload')
            end

          end

          unless x['expiration'].nil?

          end

          unless x['filter'].nil?

            unless !x['filter']['prefix'].nil? && !x['filter']['prefix'].to_s.empty?
              raise ParameterRequiredError.new('prefix', 'filter')
              end

          end

          if x['filter'].nil?
            raise ParameterRequiredError.new('filter', 'rule')
          end

          unless !x['id'].nil? && !x['id'].to_s.empty?
            raise ParameterRequiredError.new('id', 'rule')
          end

          unless !x['status'].nil? && !x['status'].to_s.empty?
            raise ParameterRequiredError.new('status', 'rule')
          end

          if x['status'] && !x['status'].to_s.empty?
            status_valid_values = %w[enabled disabled]
            unless status_valid_values.include? x['status'].to_s
              raise ParameterValueNotAllowedError.new(
                'status',
                x['status'],
                status_valid_values,
              )
            end
          end

          next if x['transition'].nil?

          unless !x['transition']['storage_class'].nil? && !x['transition']['storage_class'].to_s.empty?
            raise ParameterRequiredError.new('storage_class', 'transition')
          end
        end
      end

      public

      # put_bucket_logging: Set bucket logging of the bucket.
      # Documentation URL: https://docs.qingcloud.com/qingstor/api/bucket/logging/put_logging.html
      def put_logging(target_bucket: '',
                      target_prefix: '')
        request = put_logging_request target_bucket: target_bucket,
                                      target_prefix: target_prefix
        request.send
      end

      def put_logging_request(target_bucket: '',
                              target_prefix: '')
        input = {
          config:           config,
          properties:       properties,
          api_name:         'PUT Bucket Logging',
          request_method:   'PUT',
          request_uri:      '/<bucket-name>?logging',
          request_params:   {
          },
          request_headers:  {
          },
          request_elements: {
            'target_bucket' => target_bucket,
            'target_prefix' => target_prefix
          },
          request_body:     nil,

          status_code:      [
            200
          ]
        }

        put_bucket_logging_input_validate input
        Request.new input
      end

      private

      def put_bucket_logging_input_validate(input)
        input.deep_stringify_keys!

        unless !input['request_elements']['target_bucket'].nil? && !input['request_elements']['target_bucket'].to_s.empty?
          raise ParameterRequiredError.new('target_bucket', 'PutBucketLoggingInput')
        end

        unless !input['request_elements']['target_prefix'].nil? && !input['request_elements']['target_prefix'].to_s.empty?
          raise ParameterRequiredError.new('target_prefix', 'PutBucketLoggingInput')
        end
      end

      public

      # put_bucket_notification: Set Notification information of the bucket.
      # Documentation URL: https://docs.qingcloud.com/qingstor/api/bucket/notification/put_notification.html
      def put_notification(notifications: [])
        request = put_notification_request notifications: notifications
        request.send
      end

      def put_notification_request(notifications: [])
        input = {
          config:           config,
          properties:       properties,
          api_name:         'PUT Bucket Notification',
          request_method:   'PUT',
          request_uri:      '/<bucket-name>?notification',
          request_params:   {
          },
          request_headers:  {
          },
          request_elements: {
            'notifications' => notifications
          },
          request_body:     nil,

          status_code:      [
            200
          ]
        }

        put_bucket_notification_input_validate input
        Request.new input
      end

      private

      def put_bucket_notification_input_validate(input)
        input.deep_stringify_keys!

        unless !input['request_elements']['notifications'].nil? && !input['request_elements']['notifications'].empty?
          raise ParameterRequiredError.new('notifications', 'PutBucketNotificationInput')
        end

        input['request_elements']['notifications'].each do |x|
          unless !x['cloudfunc'].nil? && !x['cloudfunc'].to_s.empty?
            raise ParameterRequiredError.new('cloudfunc', 'notification')
          end

          if x['cloudfunc'] && !x['cloudfunc'].to_s.empty?
            cloudfunc_valid_values = %w[tupu-porn notifier image]
            unless cloudfunc_valid_values.include? x['cloudfunc'].to_s
              raise ParameterValueNotAllowedError.new(
                'cloudfunc',
                x['cloudfunc'],
                cloudfunc_valid_values,
              )
            end
          end

          unless x['cloudfunc_args'].nil?

            unless !x['cloudfunc_args']['action'].nil? && !x['cloudfunc_args']['action'].to_s.empty?
              raise ParameterRequiredError.new('action', 'cloudfunc_args')
              end

          end

          unless !x['event_types'].nil? && !x['event_types'].empty?
            raise ParameterRequiredError.new('event_types', 'notification')
          end

          unless !x['id'].nil? && !x['id'].to_s.empty?
            raise ParameterRequiredError.new('id', 'notification')
          end
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
            'statement' => statement
          },
          request_body:     nil,

          status_code:      [
            200
          ]
        }

        put_bucket_policy_input_validate input
        Request.new input
      end

      private

      def put_bucket_policy_input_validate(input)
        input.deep_stringify_keys!

        unless !input['request_elements']['statement'].nil? && !input['request_elements']['statement'].empty?
          raise ParameterRequiredError.new('statement', 'PutBucketPolicyInput')
        end

        input['request_elements']['statement'].each do |x|
          unless !x['action'].nil? && !x['action'].empty?
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
            effect_valid_values = %w[allow deny]
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

          unless !x['user'].nil? && !x['user'].empty?
            raise ParameterRequiredError.new('user', 'statement')
          end
        end
      end

      public

      # put_bucket_replication: Set Replication information of the bucket.
      # Documentation URL: https://docs.qingcloud.com/qingstor/api/bucket/replication/put_replication.html
      def put_replication(rules: [])
        request = put_replication_request rules: rules
        request.send
      end

      def put_replication_request(rules: [])
        input = {
          config:           config,
          properties:       properties,
          api_name:         'PUT Bucket Replication',
          request_method:   'PUT',
          request_uri:      '/<bucket-name>?replication',
          request_params:   {
          },
          request_headers:  {
          },
          request_elements: {
            'rules' => rules
          },
          request_body:     nil,

          status_code:      [
            200
          ]
        }

        put_bucket_replication_input_validate input
        Request.new input
      end

      private

      def put_bucket_replication_input_validate(input)
        input.deep_stringify_keys!

        unless !input['request_elements']['rules'].nil? && !input['request_elements']['rules'].empty?
          raise ParameterRequiredError.new('rules', 'PutBucketReplicationInput')
        end

        input['request_elements']['rules'].each do |x|
          if x['delete_marker'] && !x['delete_marker'].to_s.empty?
            delete_marker_valid_values = %w[enabled disabled]
            unless delete_marker_valid_values.include? x['delete_marker'].to_s
              raise ParameterValueNotAllowedError.new(
                'delete_marker',
                x['delete_marker'],
                delete_marker_valid_values,
              )
            end
          end

          unless x['destination'].nil?

            unless !x['destination']['bucket'].nil? && !x['destination']['bucket'].to_s.empty?
              raise ParameterRequiredError.new('bucket', 'destination')
              end

          end

          if x['destination'].nil?
            raise ParameterRequiredError.new('destination', 'rules')
          end

          unless x['filters'].nil?

          end

          if x['filters'].nil?
            raise ParameterRequiredError.new('filters', 'rules')
          end

          unless !x['id'].nil? && !x['id'].to_s.empty?
            raise ParameterRequiredError.new('id', 'rules')
          end

          if x['status'] && !x['status'].to_s.empty?
            status_valid_values = %w[enabled disabled]
            unless status_valid_values.include? x['status'].to_s
              raise ParameterValueNotAllowedError.new(
                'status',
                x['status'],
                status_valid_values,
              )
            end
          end

          next unless x['sync_marker'] && !x['sync_marker'].to_s.empty?

          sync_marker_valid_values = %w[enabled disabled]
          next if sync_marker_valid_values.include? x['sync_marker'].to_s

          raise ParameterValueNotAllowedError.new(
            'sync_marker',
            x['sync_marker'],
            sync_marker_valid_values,
          )
        end
      end

      public
    end
  end
end
