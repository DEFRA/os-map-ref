class InputProcessor
  attr_reader :input
  
  def initialize(input)
    @input = input
  end
  
  def params
    if map_reference_pattern =~ input
      map_reference_params
    else
      easting_northing_params
    end
  end
  
  def map_reference_params
    {map_reference: processed_map_reference}
  end
  
  def easting_northing_params
    {
      easting: nil,
      northing: nil
    }
  end
  
  def processed_map_reference
    [
      grid_letters,
      padded_map_reference_easting,
      padded_map_reference_northing
    ].join(' ')
  end
  
  def map_reference_elements
    @map_reference_elements ||= get_map_reference_elements
  end
  
  def get_map_reference_elements
    match = map_reference_pattern.match input
    (1..3).collect{|n| match[n]}
  end
  
  def grid_letters
     map_reference_elements[0]
  end
    
  def map_reference_easting
    map_reference_elements[1]
  end
  
  def map_reference_northing
    map_reference_elements[2]
  end
  
  def padded_map_reference_easting
    map_reference_easting.ljust(5, '0')
  end
  
  def padded_map_reference_northing
    target_length = northing_longer_than_easting? ? 6 : 5
    map_reference_northing.ljust(target_length, '0')
  end
  
  def northing_longer_than_easting?
    map_reference_northing.length > map_reference_easting.length
  end
  
  def map_reference_pattern
    /([a-zA-Z]{2})\s*(\d{3,5})\s*(\d{3,6})/
  end
  
end
