require 'json'

require 'qingstor/sdk'

# ----------------------------------------------------------------------------

bucket = nil

When(/^put bucket lifecycle:$/) do |lifecycle_string|
  bucket = @qs_service.bucket @test_config[:bucket_name], @test_config[:zone]
  raise if bucket.nil?

  lifecycle = JSON.parse lifecycle_string
  @put_bucket_lifecycle_output = bucket.put_lifecycle rule: lifecycle['rule']
end

Then(/^put bucket lifecycle status code is (\d+)$/) do |status_code|
  raise unless @put_bucket_lifecycle_output[:status_code].to_s == status_code
end

# ----------------------------------------------------------------------------

When(/^get bucket lifecycle$/) do
  @get_bucket_lifecycle_output = bucket.get_lifecycle
end

Then(/^get bucket lifecycle status code is (\d+)$/) do |status_code|
  raise unless @get_bucket_lifecycle_output[:status_code].to_s == status_code
end

Then(/^get bucket lifecycle should have filter prefix "([^"]*)"$/) do |prefix|
  ok = false
  @get_bucket_lifecycle_output[:rule].each { |rule| ok = true if rule[:filter][:prefix] == prefix }
  raise unless ok
end
# ----------------------------------------------------------------------------

When(/^delete bucket lifecycle$/) do
  @delete_bucket_lifecycle_output = bucket.delete_lifecycle
end

Then(/^delete bucket lifecycle status code is (\d+)$/) do |status_code|
  raise unless @delete_bucket_lifecycle_output[:status_code].to_s == status_code
end
