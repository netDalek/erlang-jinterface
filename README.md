# Erlang::Jinterface

This gem allows you to run rpc from jruby code to erlang node

## Installation

Add this line to your application's Gemfile:

    gem 'erlang-jinterface'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install erlang-jinterface

## Usage

See connection_spec.rb for usage examples

Types mapping table

| Erlang type | Ruby type |
| ----------- | --------- |
| OtpErlangFloat | Float |
| OtpErlangDouble | Float |
| OtpErlangAtom | Symbol |
| OtpErlangList | Array |
| OtpErlangBinary | String or Array of bytes. Default is UTF-8 string. Add option {binary: :array} to convert to array and {binary: :ascii_string} to convert to ASCII_8BIT sting |
| OtpErlangLong | Integer |
| OtpErlangString | String or Array of bytes. Default is UTF-8 string. Add option {otp_string: :array} to convert to array |
| OtpErlangTuple | Array with additional first element :tuple. So {ok, 1} becomes [:tuple, :ok, 1]
| OtpErlangMap | Hash |

| Ruby type | Erlang  type |
| --------- | ------------ |
| Float | OtpErlangFloat |
| Float | OtpErlangDouble |
| Symbol | OtpErlangAtom |
| Array | OtpErlangList |
| ASCII-8BIT String | Binary |
| not ASCII-8BIT String | Binary or String(List). Default is binary. Add option {ruby_string: :string} to convet to string(list) |
| Integer | OtpErlangLong |
| String | OtpErlangString |
| Array with additional first element :tuple, like [:tuple, :ok, 1] | OtpErlangTuple |
| Hash | OtpErlangMap |

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
