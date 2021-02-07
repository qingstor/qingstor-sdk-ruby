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

require 'yaml'

Dir[File.dirname(__FILE__) + '../../lib/qingstor/sdk/**/*.rb'].each { |file| require file }

module QingStorWorld
  def load_test_config
    @test_config = YAML.load_file './test_config.yaml'
    @test_config[:bucket_name] = @test_config['bucket_name']
    @test_config[:zone] = @test_config['zone']

    @test_config[:retry_wait_time] = @test_config['retry_wait_time']
    @test_config[:max_retries] = @test_config['max_retries']
  end

  def load_test_config_from_env
    @test_config = {}
    @test_config[:bucket_name] = ENV['QINGSTOR_BUCKET_NAME']
    @test_config[:zone] = ENV['QINGSTOR_ZONE']
  end

  def load_config
    @config = QingStor::SDK::Config.new.load_config_from_file './config.yaml'
    @config.check
  end

  def load_config_from_env
    @config = QingStor::SDK::Config.new.load_env_config
    @config.check
  end

  def init_qingstor_service
    @qs_service = QingStor::SDK::Service.new @config
  end
end

World(QingStorWorld)
