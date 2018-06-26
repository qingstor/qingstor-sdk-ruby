require 'json'

require 'qingstor/sdk'

# ----------------------------------------------------------------------------

bucket = nil

When(/^put bucket notification:$/) do |notification_string|
  bucket = @qs_service.bucket @test_config[:bucket_name], @test_config[:zone]
  raise if bucket.nil?

  notification = JSON.parse notification_string
  @put_bucket_notification_output = bucket.put_notification notifications: notification['notifications']
end

Then(/^put bucket notification status code is (\d+)$/) do |status_code|
  raise unless @put_bucket_notification_output[:status_code].to_s == status_code
end

# ----------------------------------------------------------------------------

When(/^get bucket notification$/) do
  @get_bucket_notification_output = bucket.get_notification
end

Then(/^get bucket notification status code is (\d+)$/) do |status_code|
  raise unless @get_bucket_notification_output[:status_code].to_s == status_code
end

Then(/^get bucket notification should have cloudfunc "([^"]*)"$/) do |cloudfunc|
  ok = false
  @get_bucket_notification_output[:notifications].each { |notifications| ok = true if notifications[:cloudfunc] == cloudfunc }
  raise unless ok
end
# ----------------------------------------------------------------------------

When(/^delete bucket notification$/) do
  @delete_bucket_notification_output = bucket.delete_notification
end

Then(/^delete bucket notification status code is (\d+)$/) do |status_code|
  raise unless @delete_bucket_notification_output[:status_code].to_s == status_code
end
