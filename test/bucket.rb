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

When(/^initialize the bucket$/) do
  bucket = @qs_service.bucket @test_config[:bucket_name], @test_config[:zone]
end

Then(/^the bucket is initialized$/) do
  raise if bucket.nil?
end

# ----------------------------------------------------------------------------

When(/^put bucket$/) do
end

Then(/^put bucket status code is (\d+)$/) do |status_code|
  status_code
end

When(/^put same bucket again$/) do
  @put_same_bucket_output = bucket.put
end

Then(/^put same bucket again status code is (\d+)$/) do |status_code|
  raise unless @put_same_bucket_output[:status_code].to_s == status_code
end

# ----------------------------------------------------------------------------

When(/^list objects$/) do
  @list_objects_output = bucket.list_objects prefix: 'Test/'
end

Then(/^list objects status code is (\d+)$/) do |status|
  raise unless @list_objects_output[:status_code].to_s == status
end

Then(/^list objects keys count is (\d+)$/) do |status|
  raise unless @list_objects_output[:keys].length.to_s == status
end

# ----------------------------------------------------------------------------

When(/^head bucket$/) do
  @head_bucket_output = bucket.head
end

Then(/^head bucket status code is (\d+)$/) do |status_code|
  raise unless @head_bucket_output[:status_code].to_s == status_code
end

# ----------------------------------------------------------------------------

When(/^delete bucket$/) do
end

Then(/^delete bucket status code is (\d+)$/) do |status_code|
  status_code
end

# ----------------------------------------------------------------------------

When(/^delete multiple objects:$/) do |delete_objects_string|
  output_0 = bucket.put_object 'object_0'
  raise unless output_0[:status_code] == 201

  output_1 = bucket.put_object 'object_1'
  raise unless output_1[:status_code] == 201

  output_2 = bucket.put_object 'object_2'
  raise unless output_2[:status_code] == 201

  delete_objects = JSON.parse delete_objects_string
  @delete_multiple_objects_output = bucket.delete_multiple_objects(
    objects: delete_objects['objects'], quiet: delete_objects['quiet'],
  )
end

Then(/^delete multiple objects code is (\d+)$/) do |status_code|
  raise unless @delete_multiple_objects_output[:status_code].to_s == status_code
end

# ----------------------------------------------------------------------------

When(/^get bucket statistics$/) do
  @get_bucket_statistics_output = bucket.get_statistics
end

Then(/^get bucket statistics status code is (\d+)$/) do |status_code|
  raise unless @get_bucket_statistics_output[:status_code].to_s == status_code
end

Then(/^get bucket statistics status is "([^"]*)"$/) do |status|
  raise unless @get_bucket_statistics_output[:status] == status
end

# ----------------------------------------------------------------------------

Given(/^an object created by initiate multipart upload$/) do
  @list_multipart_uploads_object_key = 'list_multipart_uploads_object_key'
  @initiate_multipart_upload_output = bucket.initiate_multipart_upload(
    @list_multipart_uploads_object_key,
    content_type: 'text/plain',
  )
end

When(/^list multipart uploads$/) do
  @list_multipart_uploads_output = bucket.list_multipart_uploads
end

Then(/^list multipart uploads count is (\d+)$/) do |count|
  @abort_multipart_upload_output = bucket.abort_multipart_upload(
    @list_multipart_uploads_object_key,
    upload_id: @initiate_multipart_upload_output[:upload_id],
  )
  raise unless @list_multipart_uploads_output[:uploads].length.to_s == count
end
