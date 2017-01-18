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

# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'qingstor/sdk/version'

Gem::Specification.new do |spec|
  spec.name    = 'qingstor-sdk'
  spec.version = QingStor::SDK::VERSION
  spec.authors = ['Yunify SDK Group']
  spec.email   = ['sdk_group@yunify.com']

  spec.metadata['allowed_push_host'] = 'https://rubygems.org' if spec.respond_to?(:metadata)

  spec.summary     = 'SDK for QingStor'
  spec.description = 'The official QingStor SDK for Ruby programming language.'
  spec.homepage    = 'https://github.com/yunify/qingstor-sdk-ruby'
  spec.license     = 'Apache-2.0'

  # spec.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.files         = Dir.glob('{bin,lib}/**/*') + %w(Gemfile LICENSE README.md)
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 1.9.3'

  spec.add_runtime_dependency 'activesupport', '~> 4.1.16'
  spec.add_runtime_dependency 'net-http-persistent', '~> 2.9.4'
  spec.add_runtime_dependency 'mimemagic', '~> 0.3.2'

  spec.add_development_dependency 'bundler', '> 1.10.0'
  spec.add_development_dependency 'rake', '~> 11.3.0'
  spec.add_development_dependency 'rspec', '~> 3.5.0'
  spec.add_development_dependency 'simplecov', '~> 0.12.0'
  spec.add_development_dependency 'rubocop', '~> 0.41.0'
end
