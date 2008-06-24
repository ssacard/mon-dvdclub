require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe DvdCategory do
  before(:each) do
    @dvd_category = DvdCategory.new
  end

  it "should be valid" do
    @dvd_category.should be_valid
  end
end
