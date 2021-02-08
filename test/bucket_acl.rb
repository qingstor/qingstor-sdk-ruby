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

When(/^put bucket ACL:$/) do |acl_string|
  bucket = @qs_service.bucket @test_config[:bucket_name], @test_config[:zone]
  raise if bucket.nil?

  acl = JSON.parse acl_string
  @put_bucket_acl_output = bucket.put_acl acl: acl['acl']
end

Then(/^put bucket ACL status code is (\d+)$/) do |status_code|
  raise unless @put_bucket_acl_output[:status_code].to_s == status_code.to_s
end

# ----------------------------------------------------------------------------

When(/^get bucket ACL$/) do
  @get_bucket_acl_output = bucket.get_acl
end

Then(/^get bucket ACL status code is (\d+)$/) do |status_code|
  raise unless @get_bucket_acl_output[:status_code].to_s == status_code.to_s
end

Then(/^get bucket ACL should have grantee name "([^"]*)"$/) do |name|
  ok = false
  @get_bucket_acl_output[:acl].each { |acl| ok = true if acl[:grantee][:name] == name }
  raise unless ok
end
