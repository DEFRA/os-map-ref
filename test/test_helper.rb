$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'os_map_ref'

require 'minitest/autorun'

class Minitest::Test
  
  def map_reference
    @map_reference ||= 'ST 58901 71053'
  end

  def northing
    171053
  end

  def easting
    358901
  end
  
end
