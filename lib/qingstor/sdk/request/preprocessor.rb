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

require 'cgi'
require 'base64'
require 'digest'

require 'active_support/core_ext/hash/keys'
require 'mimemagic'

module QingStor
  module SDK
    class Preprocessor
      def self.preprocess(input)
        input                    = decorate_input input
        input[:request_endpoint] = request_endpoint input
        input[:request_uri]      = request_uri input
        input[:request_body]     = request_body input
        input[:request_headers]  = request_headers input
        input[:request_params]   = request_params input

        display = {}
        input.each { |k, v| display[k] = v unless k.to_s == 'request_body' }
        Logger.info "Preprocess QingStor request: [#{input[:id]}] #{display}"
        input
      end

      def self.request_endpoint(input)
        config = input[:config]
        zone = input[:properties] ? input[:properties][:zone] : nil
        if zone
          "#{config[:protocol]}://#{zone}.#{config[:host]}:#{config[:port]}"
        else
          "#{config[:protocol]}://#{config[:host]}:#{config[:port]}"
        end
      end

      def self.request_uri(input)
        unless input[:properties].nil?
          input[:properties].each do |k, v|
            input[:request_uri].gsub! "<#{k}>", (escape v.to_s)
          end
        end
        input[:request_uri]
      end

      def self.request_body(input)
        body = input[:request_body]
        body = body.is_a?(File) ? body.read : body
        return body if body

        if input[:request_elements] && !input[:request_elements].empty?
          json_body = JSON.generate input[:request_elements]
          Logger.info "QingStor request json: [#{input[:id]}] #{json_body}"
          json_body
        end
      end

      def self.request_headers(input)
        unless input[:request_headers][:Date]
          input[:request_headers][:Date] = Time.now.utc.strftime '%a, %d %b %Y %H:%M:%S GMT'
        end
        if !input[:request_headers][:'Content-Length'] && input[:request_body]
          input[:request_headers][:'Content-Length'] = input[:request_body].length
        end
        if input[:request_method] == 'POST' ||
           input[:request_method] == 'PUT' ||
           input[:request_method] == 'DELETE'
          unless input[:request_headers][:'Content-Type']
            if input[:request_elements] && !input[:request_elements].empty?
              input[:request_headers][:'Content-Type'] = 'application/json'
            else
              input[:request_headers][:'Content-Type'] = MimeMagic.by_path input[:request_uri]
            end
          end
        end
        unless input[:request_headers][:'Content-Type']
          input[:request_headers][:'Content-Type'] = 'application/octet-stream'
        end
        unless input[:request_headers][:'User-Agent']
          ua = "qingstor-sdk-ruby/#{QingStor::SDK::VERSION} (Ruby v#{RUBY_VERSION}; #{RUBY_PLATFORM})"
          if input[:config][:additional_user_agent] && !input[:config][:additional_user_agent].empty?
            ua = "#{ua} #{input[:config][:additional_user_agent]}"
          end
          input[:request_headers][:'User-Agent'] = ua
        end

        if input[:api_name] == 'Delete Multiple Objects'
          input[:request_headers][:'Content-MD5'] = Base64.encode64(Digest::MD5.digest(input[:request_body])).strip
        end

        input[:request_headers].map do |k, v|
          input[:request_headers][k] = escape v.to_s unless v.to_s.ascii_only?
        end

        input[:request_headers]
      end

      def self.request_params(input)
        unless input[:request_params].nil?
          input[:request_params].map do |k, v|
            input[:request_params][k] = escape v.to_s
          end
        end
        input[:request_params]
      end

      def self.decorate_input(input)
        input.deep_symbolize_keys!
        input[:id] = (Random.new.rand * 1_000_000).to_int
        compact input
      end

      def self.compact(object)
        object.each do |k, v|
          object[k] = compact v if v.is_a? Hash
          object.delete k if v.nil? || v == ''
        end
        object
      end

      def self.escape(origin)
        origin = CGI.escape origin
        origin.gsub! '%2F', '/'
        origin.gsub! '%3D', '='
        origin.gsub! '+', '%20'
        origin
      end
    end
  end
end
