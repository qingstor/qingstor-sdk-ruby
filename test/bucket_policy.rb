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

When(/^put bucket policy:$/) do |policy_string|
  bucket = @qs_service.bucket @test_config[:bucket_name], @test_config[:zone]
  raise if bucket.nil?

  policy = JSON.parse policy_string
  unless policy['statement'].empty?
    policy['statement'][0]['resource'] = ["#{@test_config[:bucket_name]}/*"]
  end
  @put_bucket_policy_output = bucket.put_policy statement: policy['statement']
end

Then(/^put bucket policy status code is (\d+)$/) do |status_code|
  raise unless @put_bucket_policy_output[:status_code].to_s == status_code.to_s
end

# ----------------------------------------------------------------------------

When(/^get bucket policy$/) do
  @get_bucket_policy_output = bucket.get_policy
end

Then(/^get bucket policy status code is (\d+)$/) do |status_code|
  raise unless @get_bucket_policy_output[:status_code].to_s == status_code.to_s
end

Then(/^get bucket policy should have Referer "([^"]*)"$/) do |compare|
  ok = false
  @get_bucket_policy_output[:statement].each do |statement|
    statement[:condition][:string_like][:Referer].each do |referer|
      ok = true if referer == compare
    end
  end
  raise unless ok
end

# ----------------------------------------------------------------------------

When(/^delete bucket policy$/) do
  @delete_bucket_policy_output = bucket.delete_policy
end

Then(/^delete bucket policy status code is (\d+)$/) do |status_code|
  raise unless @delete_bucket_policy_output[:status_code].to_s == status_code.to_s
end
