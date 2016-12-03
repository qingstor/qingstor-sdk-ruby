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

require 'rspec/core/rake_task'

require 'securerandom'

RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = Dir.glob('spec/**/*_spec.rb')
  t.rspec_opts = '--format documentation'
  t.rspec_opts << ' --color'
end

task :'spec-runtime-ruby-2.3' do
  run_spec_in_docker '# Dockerfile for Runtime Test
FROM ruby:2.3

ADD . /qingstor-sdk-ruby
WORKDIR /qingstor-sdk-ruby

RUN gem install bundler
RUN bundle install

CMD ["rake", "spec", "build", "install"]
'
end

task :'spec-runtime-ruby-2.2' do
  run_spec_in_docker '# Dockerfile for Runtime Test
FROM ruby:2.2

ADD . /qingstor-sdk-ruby
WORKDIR /qingstor-sdk-ruby

RUN gem install bundler
RUN bundle install

CMD ["rake", "spec", "build", "install"]
'
end

task :'spec-runtime-ruby-2.1.5' do
  run_spec_in_docker '# Dockerfile for Runtime Test
FROM ruby:2.1.5

ADD . /qingstor-sdk-ruby
WORKDIR /qingstor-sdk-ruby

RUN gem install bundler
RUN bundle install

CMD ["rake", "spec", "build", "install"]
'
end

def run_spec_in_docker(dockerfile)
  id = SecureRandom.uuid.delete '-'

  file = File.open "./#{id}", 'w'
  file.write dockerfile
  file.close
  system "docker build -f ./#{id} -t #{id} ."
  File.delete "./#{id}"

  system "docker run --name #{id} -t #{id}"
  system "docker rm #{id}"
  system "docker rmi #{id}"
end
