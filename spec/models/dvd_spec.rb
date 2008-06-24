require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Dvd do
  before(:each) do
    @dvd = Dvd.new
  end

  it "should be valid" do
    @dvd.should be_valid
  end
end
