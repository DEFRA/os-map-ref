# OsMapRef

This gem allows you to gather U.K. Ordnance Survey Eastings, North, and Map
References from a range of text inputs.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'os_map_ref'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install os_map_ref

## Usage

To convert a map reference to eastings and northings:

```ruby
location = OsMapRef::Location.for 'ST5880171043'

location.easting       == 358801
location.northing      == 171043
location.map_reference == 'ST 58801 71043'
```

To convert eastings and northings to a map reference:

```ruby
location = OsMapRef::Location.for '358801, 171043'

location.easting       == 358801
location.northing      == 171043
location.map_reference == 'ST 58801 71043'
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. 
Then, run `rake test` to run the tests. You can also run `bin/console` 
for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. 

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/reggieb/os_map_ref.

