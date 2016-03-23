require 'test_helper'
module OsMapRef
  class LocationTest < Minitest::Test
    
    def test_for_with_map_reference
      @location = Location.for map_reference
      assert_equal map_reference, @location.map_reference
    end
    
    def test_for_with_map_reference_with_no_spaces
      @location = Location.for map_reference.delete(' ')
      assert_equal map_reference, @location.map_reference
    end
    
    def test_for_with_easting_and_northing
      @location = Location.for [easting, northing].join(' ')
      assert_equal map_reference, @location.map_reference
    end
    
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
    
    def test_map_reference_when_created_with_easting_and_northing
      test_new_with_easting_and_northing
      assert_equal map_reference, @location.map_reference
    end
    
    def test_northing_when_created_with_map_reference
      test_new_with_map_reference
      assert_equal easting, @location.easting
    end
    
    def test_eastings_when_created_with_map_reference
      test_new_with_map_reference
      assert_equal northing, @location.northing
    end
    
    def test_grid_easting
      test_new_with_easting_and_northing
      assert_equal 3, @location.grid_easting
    end
    
    def test_short_easting
      test_new_with_easting_and_northing
      assert_equal 58901, @location.short_easting
    end
    
    def test_grid_northing
      test_new_with_easting_and_northing
      assert_equal 1, @location.grid_northing
    end
    
    def test_grid_northing_with_long_northing
      @location = Location.new easting: easting, northing: 1171053
      assert_equal 11, @location.grid_northing
    end
    
    def test_short_northing
      test_new_with_easting_and_northing
      assert_equal 71053, @location.short_northing
    end
    
    def test_short_northing_with_long_northing
      test_grid_northing_with_long_northing
      assert_equal 71053, @location.short_northing
    end
    
  end
end
