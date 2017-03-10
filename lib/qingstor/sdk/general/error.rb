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

module QingStor
  module SDK
    class SDKError < StandardError
    end

    class ConfigurationError < SDKError
      def initialize(error_message)
        @error_message = error_message
      end

      def message
        "configuration is not valid, #{@error_message}"
      end
    end

    class NetworkError < SDKError
    end

    class ParameterRequiredError < SDKError
      def initialize(parameter_name, parent_name)
        @parameter_name = parameter_name
        @parent_name = parent_name
      end

      def message
        "\"#{@parameter_name}\" is required in \"#{@parent_name}\"."
      end
    end

    class ParameterValueNotAllowedError < SDKError
      def initialize(parameter_name, parameter_value, allowed_values)
        @parameter_name = parameter_name
        @parameter_value = parameter_value
        @allowed_values = allowed_values
      end

      def message
        "\"#{@parameter_name}\" value \"#{@parameter_value}\" is not allowed, should be one of #{@allowed_values.join ', '}."
      end
    end
  end
end
