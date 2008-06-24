require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe DvdCategory do
  
  describe "being associated with other models" do  
    it "should have many dvds" do
      DvdCategory.reflect_on_association(:dvds).should_not be_nil
    end
  end
  
  describe "being created" do
    before(:each) do
      @dvd_category = DvdCategory.new
    end
  
    it "should not be valid" do
      @dvd_category.should_not be_valid
    end    
  end

end
