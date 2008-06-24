require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Format do
  
  describe "being associated with other models" do  
    it "should have many dvds" do
      Format.reflect_on_association(:dvds).should_not be_nil
    end
  end
  
  describe "being_created" do
    before(:each) do
      @format = Format.new
    end
  
    it "should not be valid" do
      @format.should_not be_valid
    end    
  end

end
