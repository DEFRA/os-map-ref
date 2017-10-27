module OsMapRef
  class InputProcessor
    attr_reader :input

    def initialize(input)
      @input = input
    end

    def params
      case input
      when map_reference_pattern
        map_reference_params
      when easting_northing_pattern
        easting_northing_params
      else
        raise OsMapRef::Error, "Unable to process input #{input}"
      end
    end

    def map_reference_params
      { map_reference: processed_map_reference }
    end

    def easting_northing_params
      {
        easting: easting_and_northing[0],
        northing: easting_and_northing[1]
      }
    end

    def processed_map_reference
      [
        grid_letters.upcase,
        padded_map_reference_easting,
        padded_map_reference_northing
      ].join(" ")
    end

    def map_reference_elements
      @map_reference_elements ||= determine_map_reference_elements
    end

    def determine_map_reference_elements
      match = map_reference_pattern.match input
      (1..3).collect { |n| match[n] }
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
      map_reference_easting.ljust((normal_length - 1), padding)
    end

    def padded_map_reference_northing
      target_length = northing_longer_than_easting? ? extended_length : normal_length
      map_reference_northing.ljust((target_length - 1), padding)
    end

    def northing_longer_than_easting?
      map_reference_northing.length > map_reference_easting.length
    end

    def map_reference_pattern
      /([a-zA-Z]{2})\s*(\d{3,5})\s*(\d{3,6})/
    end

    def easting_and_northing
      @easting_and_northing ||= determine_easting_and_northing
    end

    def determine_easting_and_northing
      match = easting_northing_pattern.match input
      easting = match[1]
      northing = match[3]
      length = northing.length > easting.length ? extended_length : normal_length
      [
        easting.ljust(normal_length, padding),
        northing.ljust(length, padding)
      ]
    end

    def extended_length
      normal_length + 1
    end

    def normal_length
      6
    end

    def padding
      "0"
    end

    # Matches are:
    # 1: First digits which may be followed with a decimal point and more digits
    # 2: The decimal point and trailing digits from first match (if present)
    # 3: Second digits which may be followed with a decimal point and more digits
    # 4: The decimal point and trailing digits from second match (if present)
    # So:
    # "1234.5, 6789.0" --> 1: "1234.5", 2: ".5", 3: "6789.0", 4: ".0"
    # "1234 6789"      --> 1: "1234",   2: nil,  3: "6789",   4: nil
    def easting_northing_pattern
      eastings = /\d{3,6}/  # 3 to 6 digits
      northings = /\d{3,7}/ # 3 to 7 digits
      decimals = /\.\d+/    # decimal point and trailing digits
      separator = /[\,\s]+/ # commas or spaces
      /(#{eastings}(#{decimals})?)#{separator}(#{northings}(#{decimals})?)/
    end
  end
end
