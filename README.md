# OsMapRef

[![Build Status](https://travis-ci.org/EnvironmentAgency/os_map_ref.svg?branch=master)](https://travis-ci.org/EnvironmentAgency/os_map_ref)

This gem allows you to gather U.K. Ordnance Survey Eastings, North, and Map
References from a range of text inputs.

## Installation

Add this line to your application's Gemfile

```ruby
gem 'os_map_ref'
```

And then update your dependencies by calling

```bash
$ bundle install
```

Or install it yourself as

```bash
$ gem install os_map_ref
```

## Usage

To convert a map reference to eastings and northings

```ruby
location = OsMapRef::Location.for 'ST5880171043'

location.easting       == 358801
location.northing      == 171043
location.map_reference == 'ST 58801 71043'
```

To convert eastings and northings to a map reference

```ruby
location = OsMapRef::Location.for '358801, 171043'

location.easting       == 358801
location.northing      == 171043
location.map_reference == 'ST 58801 71043'
```

### From OS Map Reference to Longitude and Latitude

If your end result needs to be longitude and latitude, you can combine the
OsMapRef output with that of another gem called
[global_convert](https://github.com/reggieb/global_convert)

For example

```ruby
require 'global_convert'
require 'os_map_ref'

os_location = OsMapRef::Location.for 'ST 58801 71043'

location = GlobalConvert::Location.new(
  input: {
    projection: :osgb36,
    lon: os_location.easting,
    lat: os_location.northing
  },
  output: {
    projection: :wgs84
  }
)

puts "Latitude = #{location.lat} in radians."
puts "Longitude = #{location.lon} in radians."
```

## Development

After checking out the repo, run `bin/setup` to install dependencies.
Then, run `rake test` to run the tests. You can also run `bin/console`
for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing to this project

If you have an idea you'd like to contribute please log an issue.

All contributions should be submitted via a pull request.

## License

THIS INFORMATION IS LICENSED UNDER THE CONDITIONS OF THE OPEN GOVERNMENT LICENCE found at:

http://www.nationalarchives.gov.uk/doc/open-government-licence/version/3

The following attribution statement MUST be cited in your products and applications when using this information.

> Contains public sector information licensed under the Open Government license v3

### About the license

The Open Government Licence (OGL) was developed by the Controller of Her Majesty's Stationery Office (HMSO) to enable information providers in the public sector to license the use and re-use of their information under a common open licence.

It is designed to encourage use and re-use of information freely and flexibly, with only a few conditions.
