require_relative "spec_helper"

describe OsMapRef do

  describe "::VERSION" do
    it "should be a string" do
      expect(described_class::VERSION).to be_a(String)
    end
  end
end
