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

require 'base64'
require 'cgi'
require 'openssl'

module QingStor
  module SDK
    class Signer
      def self.sign(input)
        authorization = "QS #{input[:config][:access_key_id]}:#{signature input}"
        input[:request_headers][:Authorization] = authorization

        Logger.debug "QingStor request authorization: [#{input[:id]}] #{authorization}"
        input
      end

      def self.sign_query(input, expires)
        input[:request_params][:signature] = query_signature input, expires
        input[:request_params][:access_key_id] = input[:config][:access_key_id]
        input[:request_params][:expires] = expires

        Logger.debug "QingStor query signature: [#{input[:id]}] #{input[:request_params][:signature]}"
        input
      end

      def self.signature(input)
        string_to_sign = string_to_sign(input)
        Logger.debug "QingStor request string to sign: [#{input[:id]}] #{string_to_sign}"

        Base64.encode64(
          OpenSSL::HMAC.digest(
            OpenSSL::Digest.new('sha256'),
            input[:config][:secret_access_key].to_s,
            string_to_sign,
          ),
        ).strip
      end

      def self.query_signature(input, expires)
        string_to_sign = query_string_to_sign(input, expires)
        Logger.debug "QingStor query request string to sign: [#{input[:id]}] #{string_to_sign}"

        CGI.escape Base64.encode64(
          OpenSSL::HMAC.digest(
            OpenSSL::Digest.new('sha256'),
            input[:config][:secret_access_key].to_s,
            string_to_sign,
          ),
        ).strip
      end

      def self.string_to_sign(input)
        string_to_sign = "#{input[:request_method]}\n" \
                         "#{input[:request_headers][:'Content-MD5']}\n" \
                         "#{input[:request_headers][:'Content-Type']}\n" \
                         "#{input[:request_headers][:Date]}\n"
        "#{string_to_sign}#{canonicalized_headers input}#{canonicalized_resource input}"
      end

      def self.query_string_to_sign(input, expires)
        string_to_sign = "#{input[:request_method]}\n" \
                         "#{input[:request_headers][:'Content-MD5']}\n" \
                         "#{input[:request_headers][:'Content-Type']}\n" \
                         "#{expires}\n"
        "#{string_to_sign}#{canonicalized_headers input}#{canonicalized_resource input}"
      end

      def self.canonicalized_headers(input)
        h = {}
        input[:request_headers].each { |k, v| h[k.to_s.strip.downcase] = v.to_s.strip }
        h.keys.sort.reject { |k| !k.start_with? 'x-qs-' }.map { |k| "#{k}:#{h[k]}\n" }.join ''
      end

      def self.canonicalized_resource(input)
        params = input[:request_params].keys.sort.map { |k|
          if sub_resource? k.to_s
            v = input[:request_params][k].to_s.strip
            !v.nil? && v != '' ? "#{k}=#{CGI.unescape v}" : k
          end
        }.compact.join '&'
        params = input[:request_uri].include?('?') ? "&#{params}" : "?#{params}" if params != ''
        "#{input[:request_uri]}#{params}"
      end

      def self.sub_resource?(key)
        %w(
          acl cors delete mirror part_number policy stats upload_id uploads
          response-expires response-cache-control response-content-type
          response-content-language response-content-encoding response-content-disposition
        ).include? key
      end
    end
  end
end
