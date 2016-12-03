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

require 'active_support/logger'

module QingStor
  module SDK
    class Logger
      @@logger = ActiveSupport::Logger.new STDOUT
      @@level = :warn

      def self.set_level(level)
        index = %w(debug info warn error fatal).find_index level.to_s
        @@logger.level = index.nil? ? 0 : index
        @@level = level.to_sym
      end

      set_level :warn

      def self.debug(text)
        @@logger.debug text
      end

      def self.info(text)
        @@logger.info text
      end

      def self.warn(text)
        @@logger.warn text
      end

      def self.error(text)
        @@logger.error text
      end

      def self.fatal(text)
        @@logger.fatal text
      end
    end
  end
end
