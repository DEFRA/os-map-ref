# frozen_string_literal: true

require "spec_helper"

describe OsMapRef::InputProcessor do

  let(:map_reference) { "ST 58901 71053" }
  let(:long_map_reference) { "HT 58901 71053" }
  let(:easting) { "358901" }
  let(:northing) { "171053" }

  describe ".new" do
    context "with map reference" do
      it "should return formated map reference" do
        input_cleaner = described_class.new(map_reference)
        expect(input_cleaner.params[:map_reference]).to eq(map_reference)
      end
    end

    context "with map reference without spaces" do
      it "should return formated map reference" do
        input_cleaner = described_class.new(map_reference.gsub(/\s+/, ""))
        expect(input_cleaner.params[:map_reference]).to eq(map_reference)
      end
    end

    context "with lower case map reference" do
      it "should return formated map reference" do
        input_cleaner = described_class.new(map_reference.downcase)
        expect(input_cleaner.params[:map_reference]).to eq(map_reference)
      end
    end

    context "with long map reference" do
      it "should return formated map reference" do
        input_cleaner = described_class.new(long_map_reference)
        expect(input_cleaner.params[:map_reference]).to eq(long_map_reference)
      end
    end

    context "with long map reference without spaces" do
      it "should return formated map reference" do
        input_cleaner = described_class.new(long_map_reference.gsub(/\s+/, ""))
        expect(input_cleaner.params[:map_reference]).to eq(long_map_reference)
      end
    end

    context "with six figure map reference" do
      let(:map_reference) { "ST589710" }
      it "should return formated map reference" do
        input_cleaner = described_class.new(map_reference)
        expect(input_cleaner.params[:map_reference]).to eq("ST 58900 71000")
      end
    end

    context "with easting and northings" do
      let(:expected) { { easting: easting, northing: northing } }

      it "should handle easting and nothing separated by space" do
        input = [easting, northing].join(" ")
        input_cleaner = described_class.new(input)
        expect(input_cleaner.params).to eq(expected)
      end

      it "should handle easting and nothing separated by comma" do
        input = [easting, northing].join(",")
        input_cleaner = described_class.new(input)
        expect(input_cleaner.params).to eq(expected)
      end

      it "should handle easting and nothing separated by space and space" do
        input = [easting, northing].join(", ")
        input_cleaner = described_class.new(input)
        expect(input_cleaner.params).to eq(expected)
      end
    end

    context "with short eastings and northings" do
      it "should pad out short input" do
        input = "123 456"
        input_cleaner = described_class.new(input)
        expected = { easting: "123000", northing: "456000" }
        expect(input_cleaner.params).to eq(expected)
      end
    end

    context "with short eastings and northings, but longer northing" do
      it "should pad out short input" do
        input = "456 1234"
        input_cleaner = described_class.new(input)
        expected = { easting: "456000", northing: "1234000" }
        expect(input_cleaner.params).to eq(expected)
      end
    end

    context "with decimals in eastings and northings" do
      it "should pass on the decimal elements" do
        input = "308901.4,101053.3"
        input_cleaner = described_class.new(input)
        expected = { easting: "308901.4", northing: "101053.3" }
        expect(input_cleaner.params).to eq(expected)
      end
    end

    it "should raise error on unknown input" do
      expect { described_class.new("unknown").params }.to raise_error(OsMapRef::Error)
    end
  end
end
