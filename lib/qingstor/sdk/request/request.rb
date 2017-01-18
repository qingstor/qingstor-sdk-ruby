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

require 'uri'
require 'time'
require 'json'
require 'net/http'

require 'active_support/core_ext/hash/keys'

module QingStor
  module SDK
    class Request
      attr_accessor :input, :request_url, :http_request, :http_response

      def initialize(input)
        self.input = Preprocessor.preprocess input
      end

      def send
        check
        sign
        build

        retries = input[:config][:connection_retries]
        while
          begin
            Logger.info "Sending QingStor request: [#{input[:id]}] #{request_url}"
            self.http_response = input[:config].connection.request request_url, http_request
          rescue SocketError
            retries > 0 ? retries -= 1 : (raise NetworkError)
            sleep 1
            next
          end
          break
        end

        unpack
      end

      def sign
        check
        self.input = Signer.sign input
      end

      def sign_query(timeout_seconds)
        check
        self.input = Signer.sign_query input, Time.now.to_i + timeout_seconds
      end

      def build
        params           = input[:request_params].map { |k, v| "#{k}=#{v}" }
        query_string     = !params.empty? ? "?#{params.join '&'}" : ''
        self.request_url = URI "#{input[:request_endpoint]}#{input[:request_uri]}#{query_string}"

        request      = new_http_request input[:request_method], request_url.path
        request.body = input[:request_body]
        input[:request_headers].each { |k, v| request[k.to_s] = v }

        self.http_request = request
      end

      def unpack
        output = {}
        output['status_code'] = http_response.code.to_i

        http_response.each_header { |k, v| output[k.tr('-', '_')] = v }
        if http_response['Content-Type'] == 'application/json'
          unless http_response.body.nil?
            JSON.parse(http_response.body).each { |k, v| output[k] = v }
          end
        else
          output[:body] = http_response.body
        end

        display = {}
        output.each { |k, v| display[k] = v unless k.to_s == 'body' }
        Logger.info "Parse QingStor response: [#{input[:id]}] #{display}"
        output.deep_symbolize_keys!
      end

      private

      def check
        unless !input[:config][:access_key_id].nil? && !input[:config][:access_key_id].empty?
          raise SDKError, 'access key not provided'
        end
        unless !input[:config][:secret_access_key].nil? && !input[:config][:secret_access_key].empty?
          raise SDKError, 'secret access key not provided'
        end
      end

      def new_http_request(method, url)
        case method
        when 'GET'
          Net::HTTP::Get.new url
        when 'POST'
          Net::HTTP::Post.new url
        when 'PUT'
          Net::HTTP::Put.new url
        when 'HEAD'
          Net::HTTP::Head.new url
        when 'DELETE'
          Net::HTTP::Delete.new url
        when 'OPTIONS'
          Net::HTTP::Options.new url
        else
          Logger.error "Request method \"#{method}\" not supported, fallback to GET``"
          Net::HTTP::Get.new url
        end
      end
    end
  end
end
