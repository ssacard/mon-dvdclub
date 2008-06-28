require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe DvdFormat do
  
  describe "being associated with other models" do  
    it "should have many dvds" do
      DvdFormat.reflect_on_association(:dvds).should_not be_nil
    end
  end
  
  describe "being_created" do
    before(:each) do
      @format = DvdFormat.new
    end
  
    it "should not be valid" do
      @format.should_not be_valid
    end    
  end

end
