module OsMapRef
  class Location
    def initialize(args={})
      @map_reference = args[:map_reference]
      @easting = args[:easting].to_i
      @northing = args[:northing].to_i
    end
    
    def map_reference
      @map_reference ||= build_map_reference
    end
    
    def build_map_reference
      [grid_reference_prefix, short_easting, short_northing].join(' ')
    end
    
    def easting
      @easting
    end
    
    def grid_easting
      easting.to_s[0].to_i
    end
    
    def short_easting
      easting.to_s[1..-1].to_i
    end
    
    def northing
      @northing
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
