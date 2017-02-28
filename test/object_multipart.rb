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

bucket = nil
the_upload_id = nil

When(/^initiate multipart upload with key "(.+)"$/) do |object_key|
  bucket = @qs_service.bucket @test_config[:bucket_name], @test_config[:zone]
  raise if bucket.nil?

  @initiate_multipart_upload_output = bucket.initiate_multipart_upload(
    object_key,
    content_type: 'text/plain',
  )
end

Then(/^initiate multipart upload status code is (\d+)$/) do |status_code|
  raise unless @initiate_multipart_upload_output[:status_code].to_s == status_code
  the_upload_id = @initiate_multipart_upload_output[:upload_id]
end

# ----------------------------------------------------------------------------

When(/^upload the first part with key "(.+)"$/) do |object_key|
  system 'dd if=/dev/zero of=/tmp/sdk_bin_part_0 bs=1m count=5'
  @upload_the_first_part_output = bucket.upload_multipart(
    object_key,
    upload_id:   the_upload_id,
    part_number: 0,
    body:        File.open('/tmp/sdk_bin_part_0'),
  )
  system 'rm -f /tmp/sdk_bin_part_0'
end

Then(/^upload the first part status code is (\d+)$/) do |status_code|
  raise unless @upload_the_first_part_output[:status_code].to_s == status_code
end

When(/^upload the second part with key "(.+)"$/) do |object_key|
  system 'dd if=/dev/zero of=/tmp/sdk_bin_part_1 bs=1m count=4'
  @upload_the_second_part_output = bucket.upload_multipart(
    object_key,
    upload_id:   the_upload_id,
    part_number: 1,
    body:        File.open('/tmp/sdk_bin_part_1'),
  )
  system 'rm -f /tmp/sdk_bin_part_1'
end

Then(/^upload the second part status code is (\d+)$/) do |status_code|
  raise unless @upload_the_second_part_output[:status_code].to_s == status_code
end

When(/^upload the third part with key "(.+)"$/) do |object_key|
  system 'dd if=/dev/zero of=/tmp/sdk_bin_part_2 bs=1m count=3'
  @upload_the_third_part_output = bucket.upload_multipart(
    object_key,
    upload_id:   the_upload_id,
    part_number: 2,
    body:        File.open('/tmp/sdk_bin_part_2'),
  )
  system 'rm -f /tmp/sdk_bin_part_2'
end

Then(/^upload the third part status code is (\d+)$/) do |status_code|
  raise unless @upload_the_third_part_output[:status_code].to_s == status_code
end

# ----------------------------------------------------------------------------

list_multipart_output = nil

When(/^list multipart with key "(.+)"$/) do |object_key|
  list_multipart_output = bucket.list_multipart(
    object_key,
    upload_id: the_upload_id,
  )
end

Then(/^list multipart status code is (\d+)$/) do |status_code|
  raise unless list_multipart_output[:status_code].to_s == status_code
end

Then(/^list multipart object parts count is (\d+)$/) do |count|
  raise unless list_multipart_output[:object_parts].length.to_s == count
end

# ----------------------------------------------------------------------------

When(/^complete multipart upload with key "(.+)"$/) do |object_key|
  @complete_multipart_upload_output = bucket.complete_multipart_upload(
    object_key,
    upload_id:    the_upload_id,
    etag:         '"4072783b8efb99a9e5817067d68f61c6"',
    object_parts: list_multipart_output[:object_parts],
  )
end

Then(/^complete multipart upload status code is (\d+)$/) do |status_code|
  raise unless @complete_multipart_upload_output[:status_code].to_s == status_code
end

# ----------------------------------------------------------------------------

When(/^abort multipart upload with key "(.+)"$/) do |object_key|
  @abort_multipart_upload_output = bucket.abort_multipart_upload(
    object_key,
    upload_id: the_upload_id,
  )
end

Then(/^abort multipart upload status code is (\d+)$/) do |status_code|
  raise unless @abort_multipart_upload_output[:status_code].to_s == status_code
end

# ----------------------------------------------------------------------------

When(/^delete the multipart object with key "(.+)"$/) do |object_key|
  @delete_multipart_object_output = bucket.delete_object object_key
end

Then(/^delete the multipart object status code is (\d+)$/) do |status_code|
  raise unless @delete_multipart_object_output[:status_code].to_s == status_code
end
