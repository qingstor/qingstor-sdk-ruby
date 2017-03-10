# QingStor::SDK

<span style="display: inline-block">
[![Build Status](https://travis-ci.org/yunify/qingstor-sdk-ruby.svg?branch=master)](https://travis-ci.org/yunify/qingstor-sdk-ruby)
[![Gem Version](https://badge.fury.io/rb/qingstor-sdk.svg)](http://badge.fury.io/rb/qingstor-sdk)
[![API Reference](http://img.shields.io/badge/api-reference-green.svg)](https://docs.qingcloud.com/qingstor/)
[![License](http://img.shields.io/badge/license-apache%20v2-blue.svg)](https://github.com/yunify/qingstor-sdk-ruby/blob/master/LICENSE)
</span>

The official QingStor SDK for Ruby programming language.

## Installation

This Gem uses Ruby's _keyword arguments_ feature, thus Ruby v2.1.5 or higher is
required.  See [this article](https://robots.thoughtbot.com/ruby-2-keyword-arguments)
for more details about _keyword arguments_.

_Notice:_ If you are using Ruby v1.9.x, please checkout the [compatible] branch.

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

___Code Example:___

``` ruby
require 'qingstor/sdk'

# Load default configuration
config = QingStor::SDK::Config.new.load_default_config

# Create with default value
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
connection_retries: 3

# Valid log levels are "debug", "info", "warn", "error", and "fatal".
log_level: 'warn'
```

## Change Log
All notable changes to QingStor SDK for Ruby will be documented here.

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

- [QingStor Documentation](https://docs.qingcloud.com/qingstor/index.html)
- [QingStor Guide](https://docs.qingcloud.com/qingstor/guide/index.html)
- [QingStor APIs](https://docs.qingcloud.com/qingstor/api/index.html)

## Contributing

1. Fork it ( https://github.com/yunify/qingstor-sdk-ruby/fork )
2. Create your feature branch (`git checkout -b new-feature`)
3. Commit your changes (`git commit -asm 'Add some feature'`)
4. Push to the branch (`git push origin new-feature`)
5. Create a new Pull Request

## LICENSE

The Apache License (Version 2.0, January 2004).

[compatible]: https://github.com/yunify/qingstor-sdk-ruby/tree/compatible
[v2.2.0]: https://github.com/yunify/qingstor-sdk-ruby/compare/v2.1.2...v2.2.0
[v2.1.1]: https://github.com/yunify/qingstor-sdk-ruby/compare/v2.1.0...v2.1.1
[v2.1.0]: https://github.com/yunify/qingstor-sdk-ruby/compare/v2.0.1...v2.1.0
[v2.0.1]: https://github.com/yunify/qingstor-sdk-ruby/compare/v2.0.0...v2.0.1
