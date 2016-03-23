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
    
  end
end
