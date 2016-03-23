module OsMapRef
  class Location
    def initialize(args)
      @map_reference = args[:map_reference]
      @easting = args[:easting].to_i
      @northing = args[:northing].to_i
    end
    
    def map_reference
      @map_reference
    end
    
    def easting
      @easting
    end
    
    def northing
      @northing
    end
  end
end
