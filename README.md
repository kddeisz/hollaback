# Hollaback

[![Build Status](https://travis-ci.com/localytics/hollaback.svg?token=kQUiABmGkzyHdJdMnCnv&branch=master)](https://travis-ci.com/localytics/hollaback)
[![Coverage Status](https://coveralls.io/repos/github/localytics/hollaback/badge.svg?branch=master&t=Y84cXi)](https://coveralls.io/github/localytics/hollaback?branch=master)
[![Artifactory Version](http://artifactory-badge.gw.localytics.com/gem/hollaback)](https://localytics.artifactoryonline.com/localytics/webapp/#/home)

Builds method chains such that you can execute functions inside of a predefined set of callbacks.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hollaback'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hollaback

## Usage

```ruby
class Callbacker
  def say_hello
    puts 'hello'
  end

  def say_goodbye
    puts 'goodbye'
  end

  def say(&block)
    print 'speaking... '
    print yield
    puts ' ...done.'
  end
end

require 'hollaback'
chain = Hollaback::Chain.new

chain.before :say_hello
chain.after :say_goodbye
chain.around :say

chain.compile { 'Hello world' }.call(Callbacker.new)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/localytics/hollaback.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).