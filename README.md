# OsMapRef

[![Build Status](https://travis-ci.com/DEFRA/os-map-ref.svg?branch=main)](https://travis-ci.com/DEFRA/os-map-ref)
[![Maintainability Rating](https://sonarcloud.io/api/project_badges/measure?project=DEFRA_os-map-ref&metric=sqale_rating)](https://sonarcloud.io/dashboard?id=DEFRA_os-map-ref)
[![Coverage](https://sonarcloud.io/api/project_badges/measure?project=DEFRA_os-map-ref&metric=coverage)](https://sonarcloud.io/dashboard?id=DEFRA_os-map-ref)
[![security](https://hakiri.io/github/DEFRA/os-map-ref/main.svg)](https://hakiri.io/github/DEFRA/os-map-ref/main)
[![Gem Version](https://badge.fury.io/rb/os_map_ref.svg)](https://badge.fury.io/rb/os_map_ref)
[![Licence](https://img.shields.io/badge/Licence-OGLv3-blue.svg)](http://www.nationalarchives.gov.uk/doc/open-government-licence/version/3)

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

### Handling short easting/northing input values
If the full input easting or northing value has fewer than six digits, for example a northing value for a location in the south of England, the input value should be left-zero-padded within the input string. For example:

*Without* a leading zero on the northing input value, the map reference is for a location in Fife, Scotland:
```ruby
location = OsMapRef::Location.for '358801, 71043'

location.easting       == 358801
location.northing      == 710430
location.map_reference == 'NO 58801 10430'
```

Whereas *with* a leading zero on the northing input value, the map reference is for a location in Dorset, England.
```ruby
location = OsMapRef::Location.for '358801, 071043'

location.easting       == 358801
location.northing      == 071043
location.map_reference == 'SY 58801 71043'
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

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bundle exec rake` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

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
