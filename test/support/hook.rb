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

is_started = false
prepare_bucket = nil

Before do
  if ENV['WORKFLOW_INTEGRATION_TEST']
    load_test_config_from_env; load_config_from_env; init_qingstor_service
  else
    load_test_config; load_config; init_qingstor_service
  end

  unless prepare_bucket
    prepare_bucket = @qs_service.bucket(
      @test_config[:bucket_name],
      @test_config[:zone],
    )
  end

  #  unless is_started
  #    is_started = true
  #
  #    put_output = prepare_bucket.put
  #    unless put_output[:status_code] == 201
  #      puts put_output
  #    end
  #  end
end

# at_exit {
#  test_config = YAML.load_file '../test_config.yaml'
#  test_config[:retry_wait_time] = test_config['retry_wait_time']
#  test_config[:max_retries] = test_config['max_retries']
#
#  retries = 0
#  while retries < test_config[:max_retries]
#    delete_output = prepare_bucket.delete
#    break if delete_output[:status_code] == 404
#    retries += 1
#    sleep test_config[:retry_wait_time#]
#  end
# }
