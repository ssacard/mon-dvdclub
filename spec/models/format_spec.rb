require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Format do
  before(:each) do
    @format = Format.new
  end

  it "should be valid" do
    @format.should be_valid
  end
end
