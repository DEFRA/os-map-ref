require "spec_helper"

describe OsMapRef::Location do
  
  let(:map_reference) { 'ST 58901 71053' }
  let(:long_map_reference) { 'ST 58901 121053' }
  let(:easting) { 358901 }
  let(:northing) { 171053 }
  let(:long_northing) { 1171053 }

  describe ".for" do
    it "should accept a map reference" do
      location = described_class.for map_reference
      expect(location.map_reference).to eq(map_reference)
    end
    
    it "should accept a map reference without space" do
      location = described_class.for map_reference.delete(' ')
      expect(location.map_reference).to eq(map_reference)
    end
    
    it "should accept easting and northing" do
      location = described_class.for [easting, northing].join(' ')
      expect(location.map_reference).to eq(map_reference)
    end
  end
  
  describe ".new" do   
    it "should accept easting and northing strings" do
      location = described_class.new easting: easting.to_s, northing: northing.to_s
      expect(location.easting).to eq(easting)
      expect(location.northing).to eq(northing)
    end
  end
  
  context "when initiated with map_reference" do
    let(:location) { described_class.new map_reference: map_reference }
    
    describe ".map_reference" do
      it "should return input" do
        expect(location.map_reference).to eq(map_reference)
      end
    end
    
    describe ".easting" do
      it "should be calculated from map_reference" do
        expect(location.easting).to eq(easting)
      end
    end

    describe ".northing" do
      it "should be calculated from map_reference" do
        expect(location.northing).to eq(northing)
      end
    end
  end  
  
  context "when initiated with easting and northing" do
    let(:location) { described_class.new easting: easting, northing: northing }
    
    describe ".map_reference" do
      it "should be calculated from easting and northing" do
        expect(location.map_reference).to eq(map_reference)
      end
    end
    
    describe ".easting" do
      it "should return input" do
        expect(location.easting).to eq(easting)
      end
    end

    describe ".northing" do
      it "should return input" do
        expect(location.northing).to eq(northing)
      end
    end
    
    describe ".grid_easting" do
      it "should be first number of easting" do
        expect(location.grid_easting).to eq(3)
      end
    end
    
    describe ".short_easting" do
      it "should be number after first number of easting" do
        expect(location.short_easting).to eq(58901)
      end
    end
    
    describe ".grid_northing" do
      it "should be first number of northing" do
        expect(location.grid_northing).to eq(1)
      end
    end
    
    describe ".short_northing" do
      it "should be number after first number of northing" do
        expect(location.short_northing).to eq(71053)
      end
    end
  end
  
  context "when initiated with easting and northing" do
    let(:location) { described_class.new easting: easting, northing: long_northing }
    
    describe ".grid_northing" do
      it "should be the first two numbers of northing" do
        expect(location.grid_northing).to eq(11)
      end
    end
    
    describe ".short_northing" do
      it "should be the number after the first two numbers of northing" do
        expect(location.short_northing).to eq(71053)
      end
    end
  end  
end

