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

When(/^put bucket notification:$/) do |notification_string|
  bucket = @qs_service.bucket @test_config[:bucket_name], @test_config[:zone]
  raise if bucket.nil?

  notify = JSON.parse notification_string
  @put_bucket_notification_output = bucket.put_notification notifications: notify['notifications']
end

Then(/^put bucket notification status code is (\d+)$/) do |status_code|
  raise unless @put_bucket_notification_output[:status_code].to_s == status_code.to_s
end

# ----------------------------------------------------------------------------

When(/^get bucket notification$/) do
  @get_bucket_notification_output = bucket.get_notification
end

Then(/^get bucket notification status code is (\d+)$/) do |status_code|
  raise unless @get_bucket_notification_output[:status_code].to_s == status_code.to_s
end

Then(/^get bucket notification should have cloudfunc "(.*)"$/) do |name|
  ok = false
  @get_bucket_notification_output[:notifications].each { |notify| ok = true if notify[:cloudfunc] == name }
  raise unless ok
end

# ----------------------------------------------------------------------------

When(/^delete bucket notification$/) do
  @delete_bucket_notification_output = bucket.delete_notification
end

Then(/^delete bucket notification status code is (\d+)$/) do |status_code|
  raise unless @delete_bucket_notification_output[:status_code].to_s == status_code.to_s
end
