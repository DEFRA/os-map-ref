require 'matrix'
module OsMapRef
  class Location
    def initialize(args={})
      @map_reference = args[:map_reference].freeze if args[:map_reference]
      @easting = args[:easting].to_i if args[:easting]
      @northing = args[:northing].to_i if args[:northing]
    end
    
    def map_reference
      @map_reference ||= build_map_reference.freeze
    end
    
    def build_map_reference
      [grid_reference_prefix, short_easting, short_northing].join(' ')
    end
    
    def grid_easting
      easting.to_s[0].to_i
    end
    
    def short_easting
      easting.to_s[1..-1].to_i
    end
    
    def long_northing?
      northing.to_s.length >= 7
    end
    
    def grid_northing
      northing.to_s[0..(chars_in_northing_start - 1)].to_i
    end
    
    def short_northing
      northing.to_s[chars_in_northing_start..-1].to_i
    end
    
    def chars_in_northing_start
      long_northing? ? 2 : 1
    end
    
    def grid_reference_prefix
      grid[grid_northing][grid_easting]
    end
    
    def easting
      @easting ||= easting_from_map_reference.to_i
    end
    
    def northing
      @northing ||= northing_from_map_reference.to_i
    end    
    
    def northing_from_map_reference
      northing_easting_from_map_reference[0].to_s + map_reference_parts[2]
    end
    
    def easting_from_map_reference
      northing_easting_from_map_reference[1].to_s + map_reference_parts[1]
    end
    
    # The parts should be a pair of letters then two sets of numbers
    # 'ST 58901 71053' becomes ['ST', '58901', '71053']   
    def map_reference_parts
      @map_reference_parts ||= map_reference.split
    end
    
    # Returns array of [grid_northing, grid_easting] for the gird element
    # matching the map reference start. So 'ST 58901 71053' will return [1, 3]
    def northing_easting_from_map_reference
      @northing_easting_from_map_reference ||= matrix.index map_reference_parts[0]
    end
    
    def matrix
      @matrix ||= Matrix[*grid]
    end
    
    # Grid of 100km squares as they are arranged over the UK.
    # The grid is reversed so that the origin (0,0) is the 
    # bottom left corner ('SV').
    def grid
      @grid ||= [
        %w[HL HM HN HO HP JL JM JH JO JP],
        %w[HQ HR HS HT HU JQ JR JS JT JU],
        %w[HV HW HX HY HZ JV JW JX JY JZ],
        %w[NA NB NC ND NE OA OB OC OD OE],
        %w[NF NG NH NJ NK OF OG OH OI OJ],
        %w[NL NM NN NO NP OL OM ON OO OP],
        %w[NQ NR NS NT NU OQ OR OS OT OU],
        %w[NV NW NX NY NZ OV OW OX OY OZ],
        %w[SA SB SC SD SE TA TB TC TD TE],
        %w[SF SG SH SJ SK TF TG TH TI TJ],
        %w[SL SM SN SO SP TL TM TN TO TP],
        %w[SQ SR SS ST SU TQ TR TS TT TU],
        %w[SV SW SX SY SZ TV TW TX TY TZ]
      ].reverse
    end
  end
end
