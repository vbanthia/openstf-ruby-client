# OpenSTF::Client

A Ruby client for the OpenSTF APIs. It converts Swagger documentation of OpenSTF to API Client with using [notonthehighstreet/svelte](https://github.com/notonthehighstreet/svelte) dynamically.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'openstf-ruby-client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install openstf-ruby-client

## Usage

```sh
$ bundle exec ./bin/console
[1] pry(main)> OpenSTF::Client.init(host: "your-ip:your-port", token: "your-api-key")
=> OpenSTF::Client
[2] pry(main)> OpenSTF::Client::Devices.get_devices
=> #<Faraday::Response:0x007f971291fc98
 @env=
  #<struct Faraday::Env
   method=:get,
   body=
    {"success"=>true,
     "devices"=>
      [{"abi"=>"armeabi-v7a",
        "airplaneMode"=>true,
        "battery"=>{"health"=>"good", "level"=>100, "scale"=>100, "source"=>"usb", "status"=>"full", "temp"=>29.3, "voltage"=>4.214},
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ainoya/openstf-ruby-client. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Reference

- [notonthehighstreet/svelte: Dynamic Ruby API Client from Swagger JSON Spec](https://github.com/notonthehighstreet/svelte)
- [openstf/stf: Control and manage Android devices from your browser.](https://github.com/openstf/stf)
- [openstf/stf-appium-example: Run Appium test on OpenSTF Device](https://github.com/openstf/stf-appium-example)

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

