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

When(/^put bucket lifecycle:$/) do |lifecycle_string|
  bucket = @qs_service.bucket @test_config[:bucket_name], @test_config[:zone]
  raise if bucket.nil?

  lifecycle = JSON.parse lifecycle_string
  @put_bucket_lifecycle_output = bucket.put_lifecycle rule: lifecycle['rule']
end

Then(/^put bucket lifecycle status code is (\d+)$/) do |status_code|
  raise unless @put_bucket_lifecycle_output[:status_code].to_s == status_code.to_s
end

# ----------------------------------------------------------------------------

When(/^get bucket lifecycle$/) do
  @get_bucket_lifecycle_output = bucket.get_lifecycle
end

Then(/^get bucket lifecycle status code is (\d+)$/) do |status_code|
  raise unless @get_bucket_lifecycle_output[:status_code].to_s == status_code.to_s
end

Then(/^get bucket lifecycle should have filter prefix "(.*)"$/) do |name|
  ok = false
  @get_bucket_lifecycle_output[:rule].each { |rule| ok = true if rule[:filter][:prefix] == name }
  raise unless ok
end

# ----------------------------------------------------------------------------

When(/^delete bucket lifecycle$/) do
  @delete_bucket_lifecycle_output = bucket.delete_lifecycle
end

Then(/^delete bucket lifecycle status code is (\d+)$/) do |status_code|
  raise unless @delete_bucket_lifecycle_output[:status_code].to_s == status_code.to_s
end
