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

require 'json'

require './qingstor-sdk'

# ----------------------------------------------------------------------------

bucket = nil

When(/^put bucket CORS:$/) do |cors_string|
  bucket = @qs_service.bucket @test_config[:bucket_name], @test_config[:zone]
  raise if bucket.nil?

  cors = JSON.parse cors_string
  @put_bucket_cors_output = bucket.put_cors cors_rules: cors['cors_rules']
end

Then(/^put bucket CORS status code is (\d+)$/) do |status_code|
  raise unless @put_bucket_cors_output[:status_code].to_s == status_code.to_s
end

# ----------------------------------------------------------------------------

When(/^get bucket CORS$/) do
  @get_bucket_cors_output = bucket.get_cors
end

Then(/^get bucket CORS status code is (\d+)$/) do |status_code|
  raise unless @get_bucket_cors_output[:status_code].to_s == status_code.to_s
end

Then(/^get bucket CORS should have allowed origin "([^"]*)"$/) do |name|
  ok = false
  @get_bucket_cors_output[:cors_rules].each { |rule| ok = true if rule[:allowed_origin] == name }
  raise unless ok
end

# ----------------------------------------------------------------------------

When(/^delete bucket CORS$/) do
  @delete_bucket_cors_output = bucket.delete_cors
end

Then(/^delete bucket CORS status code is (\d+)$/) do |status_code|
  raise unless @delete_bucket_cors_output[:status_code].to_s == status_code.to_s
end
