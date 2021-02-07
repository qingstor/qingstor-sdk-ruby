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

require 'qingstor/sdk'

# ----------------------------------------------------------------------------

When(/^initialize QingStor service$/) do
  init_qingstor_service
end

Then(/^the QingStor service is initialized$/) do
  raise if @qs_service.nil?
end

# ----------------------------------------------------------------------------

When(/^list buckets$/) do
  @list_buckets_output = @qs_service.list_buckets
end

Then(/^list buckets status code is (\d+)$/) do |status_code|
  raise unless @list_buckets_output[:status_code].to_s == status_code.to_s
end
