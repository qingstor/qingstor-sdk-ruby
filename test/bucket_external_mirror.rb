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

require 'qingstor/sdk'

# ----------------------------------------------------------------------------

bucket = nil

When(/^put bucket external mirror:$/) do |external_mirror_string|
  bucket = @qs_service.bucket @test_config[:bucket_name], @test_config[:zone]
  raise if bucket.nil?

  external_mirror = JSON.parse external_mirror_string
  @put_bucket_external_mirror_output = bucket.put_external_mirror(
    source_site: external_mirror['source_site'],
  )
end

Then(/^put bucket external mirror status code is (\d+)$/) do |status_code|
  raise unless @put_bucket_external_mirror_output[:status_code].to_s == status_code
end

# ----------------------------------------------------------------------------

When(/^get bucket external mirror$/) do
  @get_bucket_external_mirror_output = bucket.get_external_mirror
end

Then(/^get bucket external mirror status code is (\d+)$/) do |status_code|
  raise unless @get_bucket_external_mirror_output[:status_code].to_s == status_code
end

Then(/^get bucket external mirror should have source_site "([^"]*)"$/) do |source_site|
  raise unless @get_bucket_external_mirror_output[:source_site] == source_site
end

# ----------------------------------------------------------------------------

When(/^delete bucket external mirror$/) do
  @delete_bucket_external_mirror_output = bucket.delete_external_mirror
end

Then(/^delete bucket external mirror status code is (\d+)$/) do |status_code|
  raise unless @delete_bucket_external_mirror_output[:status_code].to_s == status_code
end
