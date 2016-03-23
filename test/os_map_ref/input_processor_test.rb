require 'test_helper'
module OsMapRef
  class InputProcessorTest < Minitest::Test
    
    def test_map_reference
      input_cleaner = InputProcessor.new(map_reference)
      assert_equal map_reference, input_cleaner.params[:map_reference]
    end
    
    def test_map_reference_without_spaces
      input_cleaner = InputProcessor.new(map_reference.gsub(/\s+/, ''))
      expected = {map_reference: map_reference}
      assert_equal map_reference, input_cleaner.params[:map_reference]
    end
    
    def test_map_reference_with_long_northing
      @map_reference = 'ST 58901 121053'
      test_map_reference
    end
    
    def test_map_reference_with_long_northing_and_without_spaces
      @map_reference = 'ST 58901 121053'
      test_map_reference_without_spaces
    end
    
    def test_map_reference_six_digits
      @map_reference = 'ST589710'
      input_cleaner = InputProcessor.new(map_reference)
      assert_equal 'ST 58900 71000', input_cleaner.params[:map_reference]
    end
    
    def test_northing_and_easting
      input = [easting, northing].join(' ')
      input_cleaner = InputProcessor.new(input)
      expected = {easting: easting, northing: northing}
      assert_equal expected, input_cleaner.params
    end
    
    def test_northing_and_easting_with_comma
      input = [easting, northing].join(',')
      input_cleaner = InputProcessor.new(input)
      expected = {easting: easting, northing: northing}
      assert_equal expected, input_cleaner.params
    end
    
    def test_northing_and_easting_with_comma_and_space
      input = [easting, northing].join(', ')
      input_cleaner = InputProcessor.new(input)
      expected = {easting: easting, northing: northing}
      assert_equal expected, input_cleaner.params
    end
    
    def test_short_northing_and_easting
      input = ['123', '456'].join(' ')
      input_cleaner = InputProcessor.new(input)
      expected = {easting: 123000, northing: 456000}
      assert_equal expected, input_cleaner.params
    end
    
  end
end
