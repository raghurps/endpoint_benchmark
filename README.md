# EndpointBenchmark

[![CircleCI](https://circleci.com/gh/rpsraghu/endpoint_benchmark/tree/master.svg?style=svg)](https://circleci.com/gh/rpsraghu/endpoint_benchmark/tree/master)

Welcome to this new gem! This gem exposes a CLI via which one can monitor average response
time for an endpoint over a given period of time

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'endpoint_benchmark'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install endpoint_benchmark

## Usage

    $ benchmark -h
    Usage: benchmark [options] [host]
    Defaults: benchmark -t https -i 10 -d 60 -n gitlab.com
        -t, --type TRANSPORT             Transport type
        -i, --interval INTERVAL          Interval over which to retry benchmarking
        -d, --duration DURATION          Duration over which benchmark iteration resides
        -n, --hostname MYDOMAIN.COM      Host to perform benchmark
        -v, --[no-]verbose               Run command in verbose mode
        -h, --help                       Show this help message
            --[no-]insecure              Use this option for self-signed certificate
            --version                    Show 
    $ benchmark -i 10 -d 10 -t https -n github.com

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/rpsraghu/endpoint_benchmark. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the EndpointBenchmark project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/rpsraghu/endpoint_benchmark/blob/master/CODE_OF_CONDUCT.md).
