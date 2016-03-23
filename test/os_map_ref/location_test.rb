require 'test_helper'
module OsMapRef
  class LocationTest < Minitest::Test
    
    def test_new_with_map_reference
      @location = Location.new map_reference: map_reference
      assert_equal map_reference, @location.map_reference
    end
    
    def test_new_with_easting_and_northing
      @location = Location.new easting: easting, northing: northing
      assert_equal easting, @location.easting
      assert_equal northing, @location.northing
    end

    def test_new_with_easting_and_northing_strings
      @location = Location.new easting: easting.to_s, northing: northing.to_s
      assert_equal easting, @location.easting
      assert_equal northing, @location.northing
    end
    
    def map_reference
      'ST 58901 71053'
    end
    
    def northing
      171053
    end
    
    def easting
      358901
    end
    
  end
end
