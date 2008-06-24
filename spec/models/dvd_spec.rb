require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Dvd do
  
  describe "being associated with other models" do  
    it "should have many waiting_lists" do
      Dvd.reflect_on_association(:waiting_lists).should_not be_nil  
    end
    
    it "should have many manufacturers" do
      Dvd.reflect_on_association(:manufacturers).should_not be_nil  
    end
    
    it "should have many directors" do
      Dvd.reflect_on_association(:directors).should_not be_nil  
    end
    
    it "should belong to a dvd_category" do
      Dvd.reflect_on_association(:dvd_category).should_not be_nil  
    end
    
    it "should have many actors" do
      Dvd.reflect_on_association(:actors).should_not be_nil  
    end
    
    it "should belong to a format" do
      Dvd.reflect_on_association(:format).should_not be_nil  
    end
    
    it "should belong  to a dvd_club" do
      Dvd.reflect_on_association(:dvd_club).should_not be_nil  
    end
    
    it "should have a owner" do
      Dvd.reflect_on_association(:owner).should_not be_nil  
    end
  end
  
  describe "while created" do
    before(:each) do
      @dvd = Dvd.new
    end
    
    it "should not be valid" do
      @dvd.should_not be_valid
    end
  end
  
end
