# QingStor::SDK

[![Build Status](https://github.com/qingstor/qingstor-sdk-ruby/workflows/Unit%20Test/badge.svg?branch=master)](https://github.com/qingstor/qingstor-sdk-ruby/actions?query=workflow%3A%22Unit+Test%22)
[![Gem Version](https://badge.fury.io/rb/qingstor-sdk.svg)](http://badge.fury.io/rb/qingstor-sdk)
[![API Reference](http://img.shields.io/badge/api-reference-green.svg)](https://docsv4.qingcloud.com/user_guide/storage/object_storage/)
[![License](http://img.shields.io/badge/license-apache%20v2-blue.svg)](https://github.com/yunify/qingstor-sdk-ruby/blob/master/LICENSE)
[![Join the chat](https://img.shields.io/badge/chat-online-blue?style=flat&logo=zulip)](https://qingstor.zulipchat.com/join/odapi42t7xhqc7v4gb2wfgjx/)

The official QingStor SDK for Ruby programming language.

## Installation

This Gem uses Ruby's _keyword arguments_ feature, thus Ruby v2.1.5 or higher is
required.  See [this article](https://robots.thoughtbot.com/ruby-2-keyword-arguments)
for more details about _keyword arguments_.

_Notice:_ As of sdk v2.4, we no longer support Ruby 2.4 and earlier versions since Ruby 2.4 has been marked as EOL. 
If you are still using Ruby 2.4 and earlier, you may not be able to use some new features of our sdk, 
so please upgrade your version of Ruby as soon as possible.

### Install from RubyGems

``` bash
$ gem install qingstor-sdk
```

### Install with Bundler

Specify `qingstor-sdk` as dependency in your application's Gemfile:

``` ruby
gem 'qingstor-sdk'
```

Ensure `qingstor-sdk` is installed as dependency with `bundle install`:

``` bash
$ bundle install
```

### Install from Source Code

Get code from GitHub:

``` bash
$ git clone git@github.com:yunify/qingstor-sdk-ruby.git
```

Build and install with bundler:

``` bash
$ cd qingstor-sdk-ruby
$ bundle install
$ bundle exec rake install
```

### Uninstall

``` bash
$ gem uninstall qingstor-sdk
```

## Usage

Before using the SDK, please make sure you already have QingCloud API access key,
apply one from [QingCloud Console](https://console.qingcloud.com/access_keys/)
otherwise.

___API Access Key Example:___

``` yaml
access_key_id: 'ACCESS_KEY_ID_EXAMPLE'
secret_access_key: 'SECRET_ACCESS_KEY_EXAMPLE'
```

### Code Example

```ruby
require 'qingstor/sdk'
require 'digest/md5'

# Create a config object with access_key_id and secret_access_key defined as
# environment variables.
config = QingStor::SDK::Config.init ENV['ENV_ACCESS_KEY_ID'],
                                    ENV['ENV_SECRET_ACCESS_KEY']

# Initialize QingStor service with the config object.
qs_service = QingStor::SDK::Service.new config

# List buckets
result = qs_service.list_buckets
# Print HTTP status code
puts result[:status_code]
# Print bucket count
puts result[:buckets].length
# Print the first bucket name
puts result[:buckets][0][:name]

# Initialize a QingStor bucket
bucket = qs_service.bucket 'test-bucket', 'pek3a'

# List objects
result = bucket.list_objects
# Print HTTP status code
puts result[:status_code]
# Print keys count
puts result[:keys].length


# Upload an object
file_path = File.expand_path '~/Desktop/Screenshot.jpg'
md5_string = Digest::MD5.file(file_path).to_s
result = bucket.put_object 'Screenshot.jpg',
                           content_md5: md5_string,
                           body:        File.open(file_path)
# Print HTTP status code.
puts result[:status_code]
```

### More Configuration

Except access_key_id and secret_access_key, you can also configure the API
server (in case of QingStor is deployed in private environment, thus has
different endpoint with public QingStor) either in the config file, or in
the program dynamically.

**Notice:** config will not be checked available when `new`, `load` and `update`, 
which will be done right before initializing `service` or `bucket`. 
If you need to check config, you should call `config.check` whenever you want.
If `check` failed, a `ConfigurationError` will be raised.

___Code Example:___

``` ruby
require 'qingstor/sdk'

# Load default configuration
config = QingStor::SDK::Config.new.load_default_config

# Create with default value
# priority from high to low: param > env > user config > default config
config = QingStor::SDK::Config.new({
  host:      'qingstor.dev',
  log_level: 'debug',
})

# Create a configuration from AccessKeyID and SecretAccessKey
config = QingStor::SDK::Config.init ENV['ENV_ACCESS_KEY_ID'],
                                    ENV['ENV_SECRET_ACCESS_KEY']

# Load configuration from config file
config = QingStor::SDK::Config.new
config = config.load_config_from_file '~/qingstor/config.yaml'

# Load configuration from env variable:
# QINGSTOR_ACCESS_KEY_ID for access_key_id
# QINGSTOR_SECRET_ACCESS_KEY for secret_access_key
# QINGSTOR_ENABLE_VIRTUAL_HOST_STYLE for enable_virtual_host_style
# QINGSTOR_ENDPOINT for endpoint
config = QingStor::SDK::Config.new.load_env_config

# Change API server
config.update({host: 'test.qingstor.com'})
```

___Default Configuration File:___

``` yaml
# QingStor services configuration

access_key_id: 'ACCESS_KEY_ID'
secret_access_key: 'SECRET_ACCESS_KEY'

host: 'qingstor.com'
port: 443
protocol: 'https'
# or set endpoint directly
# endpoint: https://qingstor.com:443

connection_retries: 3

# Additional User-Agent
additional_user_agent: ""

# Valid log levels are "debug", "info", "warn", "error", and "fatal".
log_level: warn

# SDK will use virtual host style for all API calls if enabled
enable_virtual_host_style: false
```

## Change Log
All notable changes to QingStor SDK for Ruby will be documented here.

### [v2.5.0] - 2021-02-09

### Added

- config: Add env variable support (#52)
- signer: Add support for anonymous API call (#53)
- config: Add support for endpoint (#55)
- config: Add support for enable_vhost_style (#56)

### Changed

- Request: Modify Metadata in header to apply rfc 02 (#49)
- config: Refactor config check (#54)

### [v2.4.0] - 2021-01-05

### Added

- Support to set x-qs-metadata-directive header (#29)
- Add support for bucket replication (#45)

### Changed

- ci: Transfer ci into github action (#30)

### Fixed

- Fix metadata added into signature when empty (#44)

### [v2.3.0] - 2020-05-11

### Added

- Add support for lifecycle and notification.
- Add support for bucket logging, bucket cname and append object. (#24)

### Fixed

- Modify content-type check for application/json. (#21)
- Fix sub-resources not be recognized when generate signature. (#25)
- Fix meta data not work as intended. (#26)
- Reverse fix of empty map in template, should not compact empty hash when sign. (#28)

### [v2.2.3] - 2017-03-28

### Fixed

- Fix status code of DELETE CORS API.

### [v2.2.2] - 2017-03-10

### Fixed

- Resource is not mandatory in bucket policy statement.

### [v2.2.1] - 2017-03-10

#### Added

- Allow user to append additional info to User-Agent.

### [v2.2.0] - 2017-02-28

#### Added

- Add ListMultipartUploads API.

#### Fixed

- Fix request builder & signer.

### [v2.1.1] - 2017-01-16

#### Fixed

- Fix signer bug.

### [v2.1.0] - 2016-12-24

#### Changed

- Fix signer bug.
- Add more parameters to sign.

#### Added

- Add request parameters for GET Object.
- Add IP address conditions for bucket policy.

### [v2.0.1] - 2016-12-16

#### Changed

- Improve the implementation of deleting multiple objects.

### v2.0.0 - 2016-12-14

#### Added

- QingStor SDK for the Ruby programming language.

## Reference Documentations

- [QingStor Documentation](https://docsv4.qingcloud.com/user_guide/storage/object_storage/intro/product/)
- [QingStor Guide](https://docsv4.qingcloud.com/user_guide/storage/object_storage/)
- [QingStor APIs](https://docsv4.qingcloud.com/user_guide/storage/object_storage/api/)

## Contributing

1. Fork it ( https://github.com/yunify/qingstor-sdk-ruby/fork )
2. Create your feature branch (`git checkout -b new-feature`)
3. Commit your changes (`git commit -asm 'Add some feature'`)
4. Push to the branch (`git push origin new-feature`)
5. Create a new Pull Request

## LICENSE

The Apache License (Version 2.0, January 2004).

[compatible]: https://github.com/yunify/qingstor-sdk-ruby/tree/compatible
[v2.5.0]: https://github.com/yunify/qingstor-sdk-ruby/compare/v2.4.0...v2.5.0
[v2.4.0]: https://github.com/yunify/qingstor-sdk-ruby/compare/v2.3.0...v2.4.0
[v2.3.0]: https://github.com/yunify/qingstor-sdk-ruby/compare/v2.2.3...v2.3.0
[v2.2.3]: https://github.com/yunify/qingstor-sdk-ruby/compare/v2.2.2...v2.2.3
[v2.2.2]: https://github.com/yunify/qingstor-sdk-ruby/compare/v2.2.1...v2.2.2
[v2.2.1]: https://github.com/yunify/qingstor-sdk-ruby/compare/v2.2.0...v2.2.1
[v2.2.0]: https://github.com/yunify/qingstor-sdk-ruby/compare/v2.1.1...v2.2.0
[v2.1.1]: https://github.com/yunify/qingstor-sdk-ruby/compare/v2.1.0...v2.1.1
[v2.1.0]: https://github.com/yunify/qingstor-sdk-ruby/compare/v2.0.1...v2.1.0
[v2.0.1]: https://github.com/yunify/qingstor-sdk-ruby/compare/v2.0.0...v2.0.1
